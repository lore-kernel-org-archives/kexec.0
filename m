Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iw0-f177.google.com ([209.85.214.177])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P3NvO-0000yQ-Pm
	for kexec@lists.infradead.org; Wed, 06 Oct 2010 06:56:27 +0000
Received: by iwn1 with SMTP id 1so3160453iwn.36
	for <kexec@lists.infradead.org>; Tue, 05 Oct 2010 23:56:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <655DCE1B-CFCF-403B-9E90-9A8A50F24372@freescale.com>
References: <1286306243-14236-1-git-send-email-msm@freescale.com>
	<AANLkTikW216sA4nu1bwmjLG7RY3hHwMB7A6yvKgNoNZZ@mail.gmail.com>
	<655DCE1B-CFCF-403B-9E90-9A8A50F24372@freescale.com>
Date: Wed, 6 Oct 2010 10:56:24 +0400
Message-ID: <AANLkTinxecwqU39e8Zp_xwEpcYE+LAYCTCqbhUwXOzMF@mail.gmail.com>
Subject: Re: [PATCH] kexec/ppc: Use -O0 instead of -Os for purgatory
From: Maxim Uvarov <muvarov@gmail.com>
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
To: Matthew McClintock <msm@freescale.com>
Cc: kexec@lists.infradead.org

2010/10/6 Matthew McClintock <msm@freescale.com>:
>
> On Oct 5, 2010, at 4:26 PM, Maxim Uvarov wrote:
>
>> I'm ok with that changes. I'm not sure why kernel did not turn this
>> optimization off and goes
>> with compiling crt.s with sources. There could be a reasons for that.
>> More likely to not put anything from
>> libgcc to kernel. We should do the same for purgatory code. So maybe
>> it's reasonable
>> to apply my patch and go the same way as kernel goes (but it will
>> break old compilers, that should not
>> be huge problem.)
>>
>
> Wait, do your recent patches have a similar effect?
>
> -M
>
>
Yes please try this patch with -Os:
http://lists.infradead.org/pipermail/kexec/2010-September/004595.html

It fixes it. (I tested on 8572ds).

>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>



-- 
Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
