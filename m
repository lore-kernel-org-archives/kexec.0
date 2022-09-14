Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648E5C6FA82
	for <kexec@archiver.kernel.org>; Wed, 14 Sep 2022 20:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8JYFjazYVlSyaqxOrsEcaR75WArhk3egiXZa8REoMlE=; b=a+Vqb3CNPyuhne
	flCQzaMyy8StfzRcCty/S2ZUeBlhq38Fyqoc9GJ348dYt5t5CW+zpmLhivcxsiQKteG3k/2Bbisw4
	gzUjq5rsB41s7+rVR4bewC6OL/TZUfgwhB8A6+lmlhg1eqScsmvZuj9fG7vJC5rkMElyjO5X2wcb8
	51FVppXbD+3oPaDMEh/EKzyOI6djYWlNwqvbhHrtQOms4RKVdXEJ5SmdeYP2gyzp5RmUOGUb2BwlQ
	cc/7ANi9oOe+yFwu1Qsie4v6j87WUxLu4cYxCo3SbCncLz2qUWsOGwnm8t8m9MovbvPA8Px9krjWq
	HmFtqaCnJ3Ol4AseYC/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYYqc-0097Vy-4l; Wed, 14 Sep 2022 20:19:02 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYYqZ-0097PU-Qn
	for kexec@lists.infradead.org; Wed, 14 Sep 2022 20:19:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0C549B81CB3
	for <kexec@lists.infradead.org>; Wed, 14 Sep 2022 20:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1455C433D6
	for <kexec@lists.infradead.org>; Wed, 14 Sep 2022 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663186734;
	bh=Lru7PFikr9gooa+rcfmfjS8+VVhSRnx69Y2dyir0dfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BMstrKotZRuU/6fpqWWtHEls40R0T74xGpA39Hx1Q96QHV0sIzhrkwNF7GMwR3KQX
	 Cem6orYPoPcYV6nRPCt7264M+ztbTxaXFucJvvLaGdHu+QlxkrD3nI/k4OA/uP1vLK
	 QTssqx3lIM9bk7d+cf3eyUmQDKsiMCMjwqhs6TSeqk61spt5bWd1sqVJ2TD+/8GuxF
	 rKXQFdD196CdEdl3h/U2ti1vsDN4pXP18iAsNgwUKDSWl+DTSbLBXTIIDs7xpgO7VY
	 9v+uMQxPFBrXq9h8K5qLLoyAes+2K1dPtDLtRgQ+/oPxQ5YU07ULAiEqFh05X0j4G3
	 1I51Hz+xU9aLw==
Received: by mail-vk1-f174.google.com with SMTP id x66so8039983vkb.8
        for <kexec@lists.infradead.org>; Wed, 14 Sep 2022 13:18:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo1dWgbA+JcMawzwu/NGsd0zextY6WHkNk/r9SngwjlIgJmmeJJ4
	1qh5bYZQ4u+sNp+b7W4iBJg3vqEYu8smr8uQxQ==
X-Google-Smtp-Source: AA6agR5iKd4zqjkDmalrBk7jisYALPKK0lS1iB8OaES1QH5gwnk2lDL6XD8fe2N0XD9jtwdNmPTFk5W9R/MFUIkxt4A=
X-Received: by 2002:a1f:9e44:0:b0:39e:e4ff:1622 with SMTP id
 h65-20020a1f9e44000000b0039ee4ff1622mr11608618vke.15.1663186733579; Wed, 14
 Sep 2022 13:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
 <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com> <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
 <f8c8b3dd-f77b-7917-6029-a288255fee8a@linux.ibm.com>
In-Reply-To: <f8c8b3dd-f77b-7917-6029-a288255fee8a@linux.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 14 Sep 2022 15:18:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLN-7LHJuMhR+kbGb_n09K8usmcfKVzA_fV40FHmqaaDw@mail.gmail.com>
Message-ID: <CAL_JsqLN-7LHJuMhR+kbGb_n09K8usmcfKVzA_fV40FHmqaaDw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec (ppc64)
To: Stefan Berger <stefanb@linux.ibm.com>, Palmer Dabbelt <palmer@rivosinc.com>
Cc: Nayna Jain <nayna@linux.ibm.com>, nasastry@in.ibm.com, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_131900_061798_4664549A 
X-CRM114-Status: GOOD (  16.09  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Sep 14, 2022 at 2:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 9/14/22 14:01, Rob Herring wrote:
> > On Mon, Sep 12, 2022 at 8:01 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >>
> >>
> >> Hi Rob,
> >>
> >>     can you take this series in your tree?
> >
> > IMO, it should be someone that cares about TPM, kexec, or powerpc.
> > Yes, there's code in drivers/of/, but that is purely to avoid
> > duplication of code across powerpc and arm64.
>
> What about 1/4? Can someone else take it into their tree?

I thought that was taken long ago now by Palmer in the riscv tree, but
it seems not.

In any case, it has my Ack, so yes, someone else can take it. It *can*
go in via 2 different trees (as git won't care), but we generally try
to avoid that.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
