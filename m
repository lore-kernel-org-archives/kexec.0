Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msPD6-008bFS-Hu
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 12:59:46 +0000
Date: Wed, 1 Dec 2021 20:59:03 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot
 un/plug for crash
Message-ID: <20211201125903.GQ21646@MiWiFi-R3L-srv>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
 <20211124090227.GA8026@MiWiFi-R3L-srv>
 <200f923a-d196-7475-99e3-63ff3e73b28e@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200f923a-d196-7475-99e3-63ff3e73b28e@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, akpm@linux-foundation.org

+ akpm

On 11/29/21 at 01:42pm, Eric DeVolder wrote:
> Hi, see below.
> eric
> 
> On 11/24/21 03:02, Baoquan He wrote:
> > Hi,
> > 
> > On 11/18/21 at 12:49pm, Eric DeVolder wrote:
> > ......
> > > This patchset introduces a generic crash hot un/plug handler that
> > > registers with the CPU and memory notifiers. Upon CPU or memory
> > > changes, this generic handler is invoked and performs important
> > > housekeeping, for example obtaining the appropriate lock, and then
> > > invokes an architecture specific handler to do the appropriate
> > > updates.
> > > 
> > > In the case of x86_64, the arch specific handler generates a new
> > > elfcorehdr, which reflects the current CPUs and memory regions, into a
> > > buffer. Since purgatory also does an integrity check via hash digests
> > > of the loaded segments, purgatory must also be updated with the new
> > 
> > When I tried to address this with a draft patch, I started with a
> > different way in which udev rule triggers reloading and only elfcorehdr
> > segment is updated. The update should be less time consuming. Seems
> > internal notifier is better in your way. But I didn't update purgatory
> > since I just skipped the elfcorehdr part when calculate the digest of
> > segments. The reason from my mind is kernel text, initrd must contribute
> > most part of the digest, elfcorehdr is much less, and it will simplify
> > code change more. Doing so let us have no need to touch purgatory at
> > all. What do you think?
> 
> Well certainly if purgatory did not need to be updated, then that simplifies
> matters quite a bit!
> 
> I do not have any context on the history of including elfcorehdr in the purgatory
> integrity check. I do agree with you that checking kernel, initrd, boot_params
> is most important. Perhaps allowing the elfcorehdr data structure to change
> isn't too bad without including in the integrity check is ok as there is some
> sanity checking of it by the capture kernel as it reads it for /proc/vmcore setup.

Well, I think the check has included elfcorehdr since user space
kexec-tools added the check. We can do the skipping in kexec_file load
in kernel for the time being, see if anyone has concern about the
safety or security. Since agreement has been reached, can you split out
the purgatory update and repost a new patchset with the current
frame work to only update elfcorehdr?

Any by the way, I think you have written a very great cover letter which
tells almost all details about the change. However, pity that they are
not put in patch log. In your patch log, you just tell what change is
made in the patch, but the why we need it which is the most important part
is not seen. Most of time, we can get what change has been made from the
code, surely it's very helpful if patch log has told it and can save
reviewers much time, but it's not easy to get why it's needed or
introduced if not being involved in earlier discussion or any context.
And as you know, cover letter will be stripped away whem maintainers
merge patch, only patch log is kept.

Thanks
Baoquan

> 
> > 
> > Still reviewing.
> 
> Thank you!
> 
> > 
> > > digests. The arch handler also generates a new purgatory into a
> > > buffer, performs the hash digests of the new memory segments, and then
> > > patches purgatory with the new digests.  If all succeeds, then the
> > > elfcorehdr and purgatory buffers over write the existing buffers and
> > > the new kdump image is live and ready to go. No involvement with
> > > userspace at all.
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
