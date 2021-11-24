Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpoB9-004KhX-BY
 for kexec@lists.infradead.org; Wed, 24 Nov 2021 09:03:01 +0000
Date: Wed, 24 Nov 2021 17:02:27 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot
 un/plug for crash
Message-ID: <20211124090227.GA8026@MiWiFi-R3L-srv>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com

Hi,

On 11/18/21 at 12:49pm, Eric DeVolder wrote:
......
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, which reflects the current CPUs and memory regions, into a
> buffer. Since purgatory also does an integrity check via hash digests
> of the loaded segments, purgatory must also be updated with the new

When I tried to address this with a draft patch, I started with a
different way in which udev rule triggers reloading and only elfcorehdr
segment is updated. The update should be less time consuming. Seems
internal notifier is better in your way. But I didn't update purgatory
since I just skipped the elfcorehdr part when calculate the digest of
segments. The reason from my mind is kernel text, initrd must contribute
most part of the digest, elfcorehdr is much less, and it will simplify
code change more. Doing so let us have no need to touch purgatory at
all. What do you think?

Still reviewing.

> digests. The arch handler also generates a new purgatory into a
> buffer, performs the hash digests of the new memory segments, and then
> patches purgatory with the new digests.  If all succeeds, then the
> elfcorehdr and purgatory buffers over write the existing buffers and
> the new kdump image is live and ready to go. No involvement with
> userspace at all.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
