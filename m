Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ceIi8-000811-Pg
 for kexec@lists.infradead.org; Thu, 16 Feb 2017 09:50:50 +0000
Received: by mail-pf0-x229.google.com with SMTP id e4so4654655pfg.1
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2017 01:50:27 -0800 (PST)
Date: Thu, 16 Feb 2017 18:52:15 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v32 07/13] arm64: hibernate: preserve kdump image around
 hibernation
Message-ID: <20170216095214.GF18445@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
 <20170207080904.5974-5-takahiro.akashi@linaro.org>
 <58A445B3.4080608@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58A445B3.4080608@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 15, 2017 at 12:12:35PM +0000, James Morse wrote:
> Hi Akashi,
> 
> On 07/02/17 08:08, AKASHI Takahiro wrote:
> > Since arch_kexec_protect_crashkres() removes a mapping for crash dump
> > kernel memory, the loaded contents won't be preserved around hibernation.
> > 
> > In this patch, arch_kexec_(un)protect_crashkres() are additionally called
> > before/after hibernation so that the relevant region will be mapped again
> > and restored just as the other memory regions are.
> 
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you very much.

> A quick test of this took longer than expected (writing to a slow usb device),

Really? I use a uSD card on hikey as a swap device, and it takes just
a few moments to save a hibernate image although I do the test right after
the system comes up.

> I
> suspect it is save/restoring the whole crash region (which I don't think is a
> problem).

Now that we have only page-level mappings for the crash region,
it might be possible to mark all the unused pages "reserved"
in arch_kexec_unprotect_crashkres() if called in hibernate.

-Takahiro AKASHI

> If someone turns out to use this combination of features I will look
> at improving this, (almost certainly requires core-code changes).
> 
> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
