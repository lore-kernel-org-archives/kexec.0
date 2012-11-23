Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.eu.citrix.com ([46.33.159.39])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tbgt7-0003MM-QR
 for kexec@lists.infradead.org; Fri, 23 Nov 2012 00:12:58 +0000
Message-ID: <50AEBF86.50501@citrix.com>
Date: Fri, 23 Nov 2012 00:12:54 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
In-Reply-To: <50AE6542.3020302@zytor.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On 22/11/2012 17:47, H. Peter Anvin wrote:
> The other thing that should be considered here is how utterly 
> preposterous the notion of doing in-guest crash dumping is in a system 
> that contains a hypervisor.  The reason for kdump is that on bare metal 
> there are no other options, but in a hypervisor system the right thing 
> should be for the hypervisor to do the dump (possibly spawning a clean 
> I/O domain if the I/O domain is necessary to access the media.)
>
> There is absolutely no reason to have a crashkernel sitting around in 
> each guest, consuming memory, and possibly get corrupt.
>
> 	-hpa
>

(Your reply to my email which I can see on the xen devel archive appears
to have gotten lost somewhere inside the citrix email system, so
apologies for replying out of order)

The kdump kernel loaded by dom0 is for when Xen crashes, not for when
dom0 crashes (although a dom0 crash does admittedly lead to a Xen crash)

There is no possible way it could be a separate domain; Xen completely
ceases to function as soon as jumps to the entry point of the kdump image.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
