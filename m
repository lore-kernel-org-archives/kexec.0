Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ttllh-00078b-6E
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 21:04:02 +0000
Message-ID: <50F07E2D.6010602@zytor.com>
Date: Fri, 11 Jan 2013 13:03:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
 implementation
References: <50E41973.9050705@citrix.com>
 <20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
 <50E6F81D02000078000B3245@nat28.tlf.novell.com>
 <20130104170751.GB3472@host-192-168-1-59.local.net-space.pl>
 <20130104191146.GC6721@phenom.dumpdata.com>
 <20130107123404.GA2927@host-192-168-1-59.local.net-space.pl>
 <20130107162018.GJ3219@phenom.dumpdata.com> <87ehhsqrpr.fsf@xmission.com>
 <20130111165506.GD25620@phenom.dumpdata.com> <87k3rjtqi7.fsf@xmission.com>
 <20130111205232.GC17126@redhat.com>
In-Reply-To: <20130111205232.GC17126@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, David Howells <dhowells@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jan Beulich <JBeulich@suse.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On 01/11/2013 12:52 PM, Vivek Goyal wrote:
> 
> Eric,
> 
> In a private conversation, David Howells suggested why not pass kernel
> signature in a segment to kernel and kernel can do the verification.
> 
> /sbin/kexec signature is verified by kernel at exec() time. Then
> /sbin/kexec just passes one signature segment (after regular segment) for
> each segment being loaded. The segments which don't have signature,
> are passed with section size 0. And signature passing behavior can be
> controlled by one new kexec flag.
> 
> That way /sbin/kexec does not have to worry about doing any verification
> by itself. In fact, I am not sure how it can do the verification when
> crypto libraries it will need are not signed (assuming they are not
> statically linked in).
> 
> What do you think about this idea?
> 

A signed /sbin/kexec would realistically have to be statically linked,
at least in the short term; otherwise the libraries and ld.so would need
verification as well.

Now, that *might* very well have some real value -- there are certainly
users out there who would very much want only binaries signed with
specific keys to get run on their system.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
