Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtlwP-0000UO-AF
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 21:15:05 +0000
Message-ID: <50F080C6.5070206@zytor.com>
Date: Fri, 11 Jan 2013 13:14:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
 implementation
References: <50E6F81D02000078000B3245@nat28.tlf.novell.com>
 <20130104170751.GB3472@host-192-168-1-59.local.net-space.pl>
 <20130104191146.GC6721@phenom.dumpdata.com>
 <20130107123404.GA2927@host-192-168-1-59.local.net-space.pl>
 <20130107162018.GJ3219@phenom.dumpdata.com> <87ehhsqrpr.fsf@xmission.com>
 <20130111165506.GD25620@phenom.dumpdata.com> <87k3rjtqi7.fsf@xmission.com>
 <20130111205232.GC17126@redhat.com> <50F07E2D.6010602@zytor.com>
 <20130111210801.GC12019@redhat.com>
In-Reply-To: <20130111210801.GC12019@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, David Howells <dhowells@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jan Beulich <JBeulich@suse.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On 01/11/2013 01:08 PM, Vivek Goyal wrote:
>>
>> A signed /sbin/kexec would realistically have to be statically linked,
>> at least in the short term; otherwise the libraries and ld.so would need
>> verification as well.
>
> Yes. That's the expectation. Sign only statically linked exeutables which
> don't do any of dlopen() stuff either.
>
> In fact in the patch, I fail the exec() if signed executable has
> interpreter.
>

As I said, though (and possibly not for kexec, that depends): in the 
long term we probably want a way to be able to sign all kinds binaries 
in the system.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
