Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([125.16.236.2])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aO6gE-0005bu-6l
 for kexec@lists.infradead.org; Tue, 26 Jan 2016 16:41:24 +0000
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 26 Jan 2016 22:10:51 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0QGelpO22348254
 for <kexec@lists.infradead.org>; Tue, 26 Jan 2016 22:10:48 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0QGekJD017163
 for <kexec@lists.infradead.org>; Tue, 26 Jan 2016 22:10:47 +0530
Message-ID: <1453826441.2689.8.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 26 Jan 2016 11:40:41 -0500
In-Reply-To: <20160126012031.GA3228@dhcp-128-65.nay.redhat.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
 <20160125063712.GC5616@dhcp-128-65.nay.redhat.com>
 <1453734258.2713.4.camel@linux.vnet.ibm.com>
 <20160126012031.GA3228@dhcp-128-65.nay.redhat.com>
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

Hi Dave,

On Tue, 2016-01-26 at 09:20 +0800, Dave Young wrote:
> Hi, Mimi
> 
> On 01/25/16 at 10:04am, Mimi Zohar wrote:
> > On Mon, 2016-01-25 at 14:37 +0800, Dave Young wrote:
> > > Hi, Mimi
> > > 
> > > Besides of code issues, I have several thing to be understand:
> > > 
> > > What is the effect to kexec behavior with this patchset?
> > >   - without IMA enabled (kconfig or kernel cmdline) it will be same as before?
> > 
> > Yes, without IMA configured or an IMA policy, it is the same as before.
> > 
> > >   - with IMA enabled for kernel bzImage, kexec_file_load will check both ima
> > >     signature and original pe file signature, those two mechanisms are
> > >     somehow duplicated. I'm not sure if we need both for bzImage.
> > 
> > IMA provides a uniform method of measuring and appraising all files on
> > the system, based on policy.  The IMA policy could prevent the original
> > kexec syscall.  On systems without MODULE_SIG_FORCE, the IMA policy
> > would require an IMA signature as well.  (The current patch would
> > require both, even when MODULE_SIG_FORCE is enabled.)
> 
> Hmm, enabling policy is in userspace (initramfs?) so it may not be good
> enough for secure boot case. IMA can be used as a uniform method for kexec
> kernel signature verification for !UEFI or !secure-boot case. 

Normally, the kernel is booted with a builtin policy.   The policy, if
it is being replaced, is normally replaced in the initramfs.  This patch
set introduces the concept of a signed policy.   Refer to the last 3
patches. 

> > 
> > The pe format is supported on x86.  Why require the pe file signature
> > format on all platforms?
> 
> For secure boot purpose, an uefi bootable kernel (as an uefi applicatioin)
> require it to be a pe file.
> 
> But for !secure-boot it is not mandatory.

It would be more appropriate to say that "UEFI secure boot" requires a
pe file, as opposed to "secure boot" in general.

> > > Do you have a simple usage documentation about how to test it?
> > 
> > The wiki[1] and ima-evm-ctl package[2] have directions for enabling
> > IMA/IMA-appraisal.
> > 
> > To include just the kexec image and initramfs file hashes in the IMA
> > measurement list, create a file containing the following IMA policy
> > rules.  "cat" the policy and redirect the output
> > to /sys/kernel/security/ima/policy.   After loading the kexec image and
> > initramfs, the IMA measurements will be included in the measurement list
> > (/sys/kernel/security/ima/ascii_runtime_measurements)
> > 
> > IMA policy: 
> > measure func=KEXEC_CHECK
> > measure func=INITRAMFS_CHECK
> > 
> > Appraising the kexec image and initramfs is a bit more complicated as it
> > requires creating a key, which is signed by a key on the system keyring,
> > and loading the key onto the trusted IMA keyring.  To simplify testing,
> > without CONFIG_IMA_TRUSTED_KEYRING enabled, the key being loaded onto
> > the IMA keyring does not need to be signed.  The evmctl man page[2]
> > contains directions for creating and loading the key onto the IMA
> > keyring. 
> > 
> > To appraise just the kexec image and initramfs files, add the following
> > two rules to the IMA policy and load the policy as before.  (The policy
> > can only be loaded once per boot, unless IMA_WRITE_POLICY is configured.
> > With the default appraisal policy, the policy would need to signed.)
> > Sign the kexec image and initramfs with evmctl before loading them.
> > 
> > # evmctl ima_sign -k <private key> -a sha256 <VM image>
> > # evmctl ima_sign -k <private key> -a sha256 <initramfs>
> > 
> > IMA appraise policy:
> > appraise func=KEXEC_CHECK appraise_type=imasig
> > appraise func=INITRAMFS_CHECK appraise_type=imasig
> > 
> > [1] http://sourceforge.net/p/linux-ima/wiki/Home
> > [2] http://linux-ima.sourceforge.net/evmctl.1.html
> 
> Thank you, will try
> 
> > 
> > > > +{
> > > > +	struct fd f = fdget(fd);
> > > > +	int ret = -ENOEXEC;
> > > 
> > > -EBADF looks better?
> > 
> > Sure.
> > 
> Seems you missed another comment about the policy id name?
> can the name be like below?
> KEXEC_KERNEL_CHECK
> KEXEC_INITRAMFS_CHECK

Luis suggested making the enumeration more generic, not IMA specific.  I
suggested the following:

enum kernel_read_file_id {
        READING_KEXEC_IMAGE = 1,
        READING_KEXEC_INITRAMFS,
        READING_FIRMWARE,
        READING_MODULE,
        READING_POLICY,
        READING_MAX_ID
};

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
