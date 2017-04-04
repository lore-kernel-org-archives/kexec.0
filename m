Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cvIws-0007XO-Dk
 for kexec@lists.infradead.org; Tue, 04 Apr 2017 07:32:21 +0000
Received: by mail-pg0-x235.google.com with SMTP id x125so144312164pgb.0
 for <kexec@lists.infradead.org>; Tue, 04 Apr 2017 00:31:57 -0700 (PDT)
Date: Tue, 4 Apr 2017 16:35:05 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
Message-ID: <20170404073504.GI16309@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: mark.rutland@arm.com, panand@redhat.com, ard.biesheuvel@linaro.org, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, Mark Salter <msalter@redhat.com>, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 04, 2017 at 06:14:55AM -0000, David Woodhouse wrote:
> 
> > On Mon, Apr 03, 2017 at 09:18:12AM +0100, David Woodhouse wrote:
> >>
> >> You still have typos here.
> >
> > I'd like to defer to the maintainers whether we prefer MiB over MB.
> 
> It is not really a matter of preference. One is correct; the other is not.
> 
> While simple errors can of course be forgiven, I cannot understand why you
> would deliberately repeat an error once it has been pointed out to you.

Because I think that people sometimes use those two interchangeably.
So I said I would defer to the maintainers.

-Takahiro AKASHI

> 
> 
> -- 
> dwmw2
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
