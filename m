Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C2C36010
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kb8y09wjWZKZXgN+OK6vm5oWH5+mueKid+6zGQwN3TE=; b=luGRS1yGz5NPakE46KaSTMppyl
	SwWYJ0th9GbcHnj3ssyIE66FD9oFpaf47fR8q7eBVYUaXgFfijwL9zolEgwrC8L4J5lb4aCfZKxci
	hBOqZxIaOpWswAmVBCgJSzR2kS5+J353p0BVo9wVgIIymwPOcI/hxZ/QEOhXttcypIOKvdx8HT5/V
	u3Wvf83dFhGGvdE2dqt4R5uVh8XgedKnWOBJ3J7bs3ghGhh0LdvegD/UTdRvhgTeIZAO18tvBKJzT
	iOcZ72tpIbo0EXMnuqJjZSN+5Syq1fj6ogKgu6uPWopAZhqT1qDEV2K4e0DeJCifVOxyVGWyUMTi4
	x7yQ6RGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTt-0000000B63M-3gZ2;
	Thu, 27 Mar 2025 13:41:13 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tws3B-00000004XCJ-26Qg
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 00:21:50 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-225505d1ca5so79220475ad.2
        for <kexec@lists.infradead.org>; Mon, 24 Mar 2025 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742862108; x=1743466908; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb8y09wjWZKZXgN+OK6vm5oWH5+mueKid+6zGQwN3TE=;
        b=HdX3dzj3THoZbc4zWymyjO5TUotfLrS3EUFbfdtVFjFiFtrGSBth904A60w6MpBt3E
         NaC38B0xIZ/vBSa4bQ/GNVrn++k3vBd2FjYT97AM9TcFT3OxjsDsb0BPJmJYiq18cFmv
         u4rQG8rKo7QoqmBZm1vAjo9Og4+lNXv2P+p1MifQYZH54/EHsnssYkN2y0LfeoJiojlB
         TVrgTkrcH75ypHY5QB5Gp87pdrmr/pBUq1ZZxcwKXoEBZ1uBejS/4CMPi79X2DuQ0v+V
         VyK4/kbEcrUNsa6UYKN6rX3gD4TFQjHHTm9rowz0xtVqnV0tEG2xOHvY5QtbXZyn6LOl
         xiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742862108; x=1743466908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb8y09wjWZKZXgN+OK6vm5oWH5+mueKid+6zGQwN3TE=;
        b=KlU1LTQGxWrfwQtjfWO3WVew4tHKpFo8l7Wsg7EtT9ZRvuKx87C6mYtpTBDXszs3wc
         etYCOSUSsM5G82pYbLYVjfb8KKbNtKBXzVR9ZbPgjYRCq2rLZZ09yD+eo0T59Q3s0n8i
         gxPMTLUXSMp37GX8HYz1R8aM/mHcrACO+NgF5Nec6XT/BpBvBB3cCOFS+c/5s32VLpro
         Zk4yWwbarksmkuNRYWKq9jh5Ha4hJz8mZsj7mbTz+5czFY9fytpo3oD1AXKSaw1PbnUR
         tGR1w6IOqtmQiiv8mw1cXgcaGFpTuHCYAZFn1AGC6HXP8jC9XHwopY6NCo1So3Ijfylz
         GSHA==
X-Forwarded-Encrypted: i=1; AJvYcCXrC4FIeij1vyZzGUNZYEhc8CqW9keoKVBF6SnRjSHU4/F4jWGY3NBGyelmMIm/T2n6ttO+uw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfiYGqutB5WZOD0AN3EklTiTRdLlxpDdKjoP5bNs5xJQrhevWi
	V6SNz1xuDwaddnyiRf77pLvJklcGlDQ2JfMAMJx6Jih8U+pOhFU+D7nBgO9I9f8L+sT561JCjSB
	1tlpzuG3LsMUz1LqH2Q==
X-Google-Smtp-Source: AGHT+IHG0g+Hm1IqtMzqXUj5Qn0QldzYjiLvO8Nyoi1zqCX0pxtjOavFlFPqDc4bNSQjw3dO9geHCTStZpDWLXuA
X-Received: from pfbgi10.prod.google.com ([2002:a05:6a00:63ca:b0:736:59f0:d272])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88c7:0:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-7390593d43fmr22362509b3a.2.1742862108166;
 Mon, 24 Mar 2025 17:21:48 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:21:45 -0700
In-Reply-To: <Z+GIRecXeYXiPrYv@nvidia.com>
Mime-Version: 1.0
References: <Z+GIRecXeYXiPrYv@nvidia.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325002145.982402-1-changyuanl@google.com>
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation helpers
From: Changyuan Lyu <changyuanl@google.com>
To: jgg@nvidia.com
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, 
	robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_172149_562165_0C054CEE 
X-CRM114-Status: GOOD (  32.94  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Jason,

On Mon, Mar 24, 2025 at 13:28:53 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> [...]
> > > I feel like this patch is premature, it should come later in the
> > > project along with a stronger justification for this approach.
> > >
> > > IHMO keep things simple for this series, just the very basics.
> >
> > The main purpose of using hashtables is to enable KHO users to save
> > data to KHO at any time, not just at the time of activate/finalize KHO
> > through sysfs/debugfs. For example, FDBox can save the data into KHO
> > tree once a new fd is saved to KHO. Also, using hashtables allows KHO
> > users to add data to KHO concurrently, while with notifiers, KHO users'
> > callbacks are executed serially.
>
> This is why I like the recursive FDT scheme. Each serialization
> operation can open its own FDT write to it and the close it
> sequenatially within its operation without any worries about
> concurrency.
>
> The top level just aggregates the FDT blobs (which are in preserved
> memory)
>
> To me all this complexity here with the hash table and the copying
> makes no sense compared to that. It is all around slower.
>
> > Regarding the suggestion of recursive FDT, I feel like it is already
> > doable with this patchset, or even with Mike's V4 patch.
>
> Of course it is doable, here we are really talk about what is the
> right, recommended way to use this system. recurisive FDT is a better
> methodology than hash tables
>
> > just allocates a buffer, serialize all its states to the buffer using
> > libfdt (or even using other binary formats), save the address of the
> > buffer to KHO's tree, and finally register the buffer's underlying
> > pages/folios with kho_preserve_folio().
>
> Yes, exactly! I think this is how we should operate this system as a
> paradig, not a giant FDT, hash table and so on...
>
> [...]
> > To completely remove fdt_max, I am considering the idea in [1]. At the
> > time of kexec_file_load(), we pass the address of an anchor page to
> > the new kernel, and the anchor page will later be fulfilled with the
> > physical addresses of the pages containing the FDT blob. Multiple
> > anchor pages can be linked together. The FDT blob pages can be physically
> > noncontiguous.
>
> Yes, this is basically what I suggested too. I think this is much
> prefered and doesn't require the wakky uapi.
>
> Except I suggested you just really need a single u64 to point to a
> preserved page holding the top level FDT.
>
> With recursive FDT I think we can say that no FDT fragement should
> exceed PAGE_SIZE, and things become much simpler, IMHO.

Thanks for the suggestions! I am a little bit concerned about assuming
every FDT fragment is smaller than PAGE_SIZE. In case a child FDT is
larger than PAGE_SIZE, I would like to turn the single u64 in the parent
FDT into a u64 list to record all the underlying pages of the child FDT.

To be concrete and make sure I understand your suggestions correctly,
I drafted the following design,

Suppose we have 2 KHO users, memblock and gpu@0x2000000000, the KHO
FDT (top level FDT) would look like the following,

    /dts-v1/;
    / {
            compatible = "kho-v1";
            memblock {
                    kho,recursive-fdt = <0x00 0x40001000>;
            };
            gpu@0x100000000 {
                    kho,recursive-fdt = <0x00 0x40002000>;
            };
    };

kho,recursive-fdt in "memblock" points to a page containing another
FDT,

    / {
            compatible = "memblock-v1";
            n1 {
                    compatible = "reserve-mem-v1";
                    size = <0x04 0x00>;
                    start = <0xc06b 0x4000000>;
            };
            n2 {
                    compatible = "reserve-mem-v1";
                    size = <0x04 0x00>;
                    start = <0xc067 0x4000000>;
            };
    };

Similarly, "kho,recursive-fdt" in "gpu@0x2000000000" points to a page
containing another FDT,

    / {
            compatible = "gpu-v1"
            key1 = "v1";
            key2 = "v2";

            node1 {
                    kho,recursive-fdt = <0x00 0x40003000 0x00 0x40005000>;
            }
            node2 {
                    key3 = "v3";
                    key4 = "v4";
            }
    }

and kho,recursive-fdt in "node1" contains 2 non-contagious pages backing
the following large FDT fragment,

    / {
            compatible = "gpu-subnode1-v1";

            key5 = "v5";
            key6 = "v6";
            key7 = "v7";
            key8 = "v8";
            ... // many many keys and small values
    }

In this way we assume that most FDT fragment is smaller than 1 page so
"kho,recursive-fdt" is usually just 1 u64, but we can also handle
larger fragments if that really happens.

I also allow KHO users to add sub nodes in-place, instead of forcing
to create a new FDT fragment for every sub node, if the KHO user is
confident that those subnodes are small enough to fit in the parent
node's page. In this way we do not need to waste a full page for a small
sub node. An example is the "memblock" node above.

Finally, the KHO top level FDT may also be larger than 1 page, this can
be handled using the anchor-page method discussed in the previous mails.

What do you think?

Best,
Changyuan

