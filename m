Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aDt3v-0001CA-5o
 for kexec@lists.infradead.org; Tue, 29 Dec 2015 12:07:36 +0000
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 29 Dec 2015 22:07:11 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 094133578047
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 23:07:08 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBTC6kfu34144436
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 23:06:59 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBTC6V2p014585
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 23:06:31 +1100
Message-ID: <1451390772.3078.39.camel@linux.vnet.ibm.com>
Subject: Re: [Linux-ima-devel] [PATCH v2 4/7] ima: measure and appraise
 kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 29 Dec 2015 07:06:12 -0500
In-Reply-To: <20151229082122.GA11810@dhcp-128-65.nay.redhat.com>
References: <1450914903-5793-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1450914903-5793-5-git-send-email-zohar@linux.vnet.ibm.com>
 <20151225053356.GA3398@dhcp-128-65.nay.redhat.com>
 <1451054749.3289.131.camel@linux.vnet.ibm.com>
 <20151228020829.GB2980@dhcp-128-65.nay.redhat.com>
 <1451307075.3289.224.camel@linux.vnet.ibm.com>
 <20151229082122.GA11810@dhcp-128-65.nay.redhat.com>
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
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, David Woodhouse <dwmw2@infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2015-12-29 at 16:21 +0800, Dave Young wrote:
> Hi, Mimi
> 
> On 12/28/15 at 07:51am, Mimi Zohar wrote:
> > On Mon, 2015-12-28 at 10:08 +0800, Dave Young wrote:
> > > On 12/25/15 at 09:45am, Mimi Zohar wrote:
> > > > IMA calculates the file hash, in this case, based on the buffer
> > > > contents.   The hash is calculated once and used for both measurement
> > > > and appraisal.  If the file integrity appraisal fails (eg. hash
> > > > comparison or signature failure), IMA prevents the kexec files from
> > > > being used.
> > > > 
> > > 
> > > Ok, thanks for the explanatioin. But I have another question, why do we
> > > need a special hook for KEXEC? Shouldn't all files use same way to do the
> > > measurement and appraisal?
> > 
> > "By all files" are you referring to all files read by the kernel or all
> > files opened, executed or mmapped by the system?
> 
> Hmm, I means any kind of files read by the kernel.
> 
> > 
> > Currently IMA allocates a page sized buffer, reads a file a page chunk
> > at a time calculating the file hash as it does so, and then frees the
> > buffer before returning to the caller.  This method of calculating the
> > file hash is used for measuring and appraising files opened
> > (FILE_CHECK), executed (BPRM_CHECK) or mmapped (MMAP_CHECK) by the
> > system.
> > 
> > This patch set addresses files being read by kernel.  A single new
> > generic hook named ima_hash_and_process_file() is defined to not only
> > measure and appraise the kexec image and initramfs, but firmware and the
> > IMA policy.   As we identify other places that the kernel is reading
> > files, this hook would be called in those places as well.
> 
> What I can not understand is why IMA need know the caller information and
> why cann't introduce a generic interface. kexec and firmware and other
> caller all read files, so a common file based interface should be better?

The next patch set will define a common function for reading files by
the kernel.  Luis set up a wiki
http://kernelnewbies.org/KernelProjects/common-kernel-loader with some
details.

This patch set defines a generic interface for measuring and appraising
files being read by the kernel, with the ability to define a policy
based on the caller information.   For the details on expressing a
policy, refer to Documentation/ABI/testing/ima-policy.   For example,
the new rules could be expressed like:

measure func=KEXEC_CHECK
appraise func=KEXEC_CHECK appraise_type=imasig
#
measure func=INITRAMFS_CHECK
appraise func=INITRAMFS_CHECK appraise_type=imasig
#
measure func=FIRMWARE_CHECK
appraise func=FIRMWARE_CHECK appraise_type=imasig
#
measure func=POLICY_CHECK
appraise func=POLICY_CHECK appraise_type=imasig

This policy flexibility is needed at least until all files come from
software providers with file signatures.  (RPM has been modified to
include file signatures.)  Even then, in terms of kexec, some distros
generate the initramfs on the target host and,  therefore, can not sign
the initramfs.  The local user could, however, sign the initramfs on
their own system.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
