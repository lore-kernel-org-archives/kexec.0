Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtlC2-0000Ky-VD
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 20:27:11 +0000
Message-ID: <50F07588.90902@zytor.com>
Date: Fri, 11 Jan 2013 12:26:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
 implementation
References: <50DC58C4.3000307@citrix.com> <874nj7qsor.fsf@xmission.com>
 <50E41973.9050705@citrix.com>
 <20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
 <50E6F81D02000078000B3245@nat28.tlf.novell.com>
 <20130104170751.GB3472@host-192-168-1-59.local.net-space.pl>
 <20130104191146.GC6721@phenom.dumpdata.com>
 <20130107123404.GA2927@host-192-168-1-59.local.net-space.pl>
 <20130107162018.GJ3219@phenom.dumpdata.com> <87ehhsqrpr.fsf@xmission.com>
 <20130111165506.GD25620@phenom.dumpdata.com>
In-Reply-To: <20130111165506.GD25620@phenom.dumpdata.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jan Beulich <JBeulich@suse.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

>
> And there is nothing fancy to be done for EFI and SecureBoot? Or is
> that something that the kernel has to handle on its own (so somehow
> passing some certificates to somewhere).
>

For EFI, no... other than passing the EFI parameters, which apparently 
is *not* currently done (David Woodhouse is working on it.)  Secure boot 
is still a work in progress.


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
