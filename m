Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Ttlag-0004Ty-1W
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 20:52:38 +0000
Date: Fri, 11 Jan 2013 15:52:32 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
 implementation
Message-ID: <20130111205232.GC17126@redhat.com>
References: <50E41973.9050705@citrix.com>
 <20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
 <50E6F81D02000078000B3245@nat28.tlf.novell.com>
 <20130104170751.GB3472@host-192-168-1-59.local.net-space.pl>
 <20130104191146.GC6721@phenom.dumpdata.com>
 <20130107123404.GA2927@host-192-168-1-59.local.net-space.pl>
 <20130107162018.GJ3219@phenom.dumpdata.com>
 <87ehhsqrpr.fsf@xmission.com>
 <20130111165506.GD25620@phenom.dumpdata.com>
 <87k3rjtqi7.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k3rjtqi7.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, David Howells <dhowells@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On Fri, Jan 11, 2013 at 12:26:56PM -0800, Eric W. Biederman wrote:

[..]
> Recently there is a desire to figure out how to /sbin/kexec support
> signed kernel images.  What will probably happen is to have a specially
> trusted userspace application perform the verification.  Sort of like
> dom0 for the linux userspace.  A few other ideas have been batted around
> but none that have stuck.

[ CC David Howells ]

Eric,

In a private conversation, David Howells suggested why not pass kernel
signature in a segment to kernel and kernel can do the verification.

/sbin/kexec signature is verified by kernel at exec() time. Then
/sbin/kexec just passes one signature segment (after regular segment) for
each segment being loaded. The segments which don't have signature,
are passed with section size 0. And signature passing behavior can be
controlled by one new kexec flag.

That way /sbin/kexec does not have to worry about doing any verification
by itself. In fact, I am not sure how it can do the verification when
crypto libraries it will need are not signed (assuming they are not
statically linked in).

What do you think about this idea?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
