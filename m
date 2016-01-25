Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aNii1-0005lp-Vl
 for kexec@lists.infradead.org; Mon, 25 Jan 2016 15:05:38 +0000
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 26 Jan 2016 01:05:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 07EC02BB0054
 for <kexec@lists.infradead.org>; Tue, 26 Jan 2016 02:05:11 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0PF52eL60555274
 for <kexec@lists.infradead.org>; Tue, 26 Jan 2016 02:05:11 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0PF4cmI029630
 for <kexec@lists.infradead.org>; Tue, 26 Jan 2016 02:04:38 +1100
Message-ID: <1453734258.2713.4.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2016 10:04:18 -0500
In-Reply-To: <20160125063712.GC5616@dhcp-128-65.nay.redhat.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
 <20160125063712.GC5616@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Mon, 2016-01-25 at 14:37 +0800, Dave Young wrote:
> Hi, Mimi
> 
> Besides of code issues, I have several thing to be understand:
> 
> What is the effect to kexec behavior with this patchset?
>   - without IMA enabled (kconfig or kernel cmdline) it will be same as before?

Yes, without IMA configured or an IMA policy, it is the same as before.

>   - with IMA enabled for kernel bzImage, kexec_file_load will check both ima
>     signature and original pe file signature, those two mechanisms are
>     somehow duplicated. I'm not sure if we need both for bzImage.

IMA provides a uniform method of measuring and appraising all files on
the system, based on policy.  The IMA policy could prevent the original
kexec syscall.  On systems without MODULE_SIG_FORCE, the IMA policy
would require an IMA signature as well.  (The current patch would
require both, even when MODULE_SIG_FORCE is enabled.)

The pe format is supported on x86.  Why require the pe file signature
format on all platforms?

> Do you have a simple usage documentation about how to test it?

The wiki[1] and ima-evm-ctl package[2] have directions for enabling
IMA/IMA-appraisal.

To include just the kexec image and initramfs file hashes in the IMA
measurement list, create a file containing the following IMA policy
rules.  "cat" the policy and redirect the output
to /sys/kernel/security/ima/policy.   After loading the kexec image and
initramfs, the IMA measurements will be included in the measurement list
(/sys/kernel/security/ima/ascii_runtime_measurements)

IMA policy: 
measure func=KEXEC_CHECK
measure func=INITRAMFS_CHECK

Appraising the kexec image and initramfs is a bit more complicated as it
requires creating a key, which is signed by a key on the system keyring,
and loading the key onto the trusted IMA keyring.  To simplify testing,
without CONFIG_IMA_TRUSTED_KEYRING enabled, the key being loaded onto
the IMA keyring does not need to be signed.  The evmctl man page[2]
contains directions for creating and loading the key onto the IMA
keyring. 

To appraise just the kexec image and initramfs files, add the following
two rules to the IMA policy and load the policy as before.  (The policy
can only be loaded once per boot, unless IMA_WRITE_POLICY is configured.
With the default appraisal policy, the policy would need to signed.)
Sign the kexec image and initramfs with evmctl before loading them.

# evmctl ima_sign -k <private key> -a sha256 <VM image>
# evmctl ima_sign -k <private key> -a sha256 <initramfs>

IMA appraise policy:
appraise func=KEXEC_CHECK appraise_type=imasig
appraise func=INITRAMFS_CHECK appraise_type=imasig

[1] http://sourceforge.net/p/linux-ima/wiki/Home
[2] http://linux-ima.sourceforge.net/evmctl.1.html

> > +{
> > +	struct fd f = fdget(fd);
> > +	int ret = -ENOEXEC;
> 
> -EBADF looks better?

Sure.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
