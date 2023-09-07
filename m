Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C239EE14D3
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OPI6biy+7clwy+UhXS+oemH1FNyRikxYy7zBk3Zo/RU=; b=KWgzVSbxvSrMEL
	1qoMf3Xyiumoo2k9kkpK8URfGR9+WmgQkwOGYu+dQYQHkU6crduZ8Vt/nD/zRh278LsTKPHgRuen3
	CDQIRTxkTjsOlyzm0AvBTTlQb9Ih5aYU68fW0sx328ns6qQvbiR0qTm0q7sVOocP6BBt72EXyna19
	PYrz7IAH/bz320X7BxUyhrVsHAjNT5YAtQ7+ET1sBGLfivYCZfGKxaynGRizvL/D4XDvWZEo8Oysw
	xrfeqRgDeKyuVidLk8JyA0Va/AL66j8/+zGIsvsR0JjiTQh8lScKATmzwo/p9xeKwCYFKB9LtAc7A
	fd+Roww9qN+00Zw6vgIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBUS-00BhPi-1P;
	Thu, 07 Sep 2023 09:39:56 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBUQ-00BhOa-0Y
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 09:39:55 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so14166531fa.0
        for <kexec@lists.infradead.org>; Thu, 07 Sep 2023 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694079590; x=1694684390; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSn/skXMWf/xa0+iNC5/Gw93hjM5QOQeyldszIVaJcM=;
        b=XyxKWdMAllVxRil+cnIv7J91eJc8kVdIczkjMni2g7nI3HPY2DRpTIyxlc7/4ePUs3
         tLcAliruNNt74Jcn9AiEXgklkbkQ+L5JSEw0uFEYZi3hFMIQRtDRSx7IDz9vhbg9iTVg
         Ts1uNERWb4+3uPmBiFODQnxaZtGOHSrTM0yrAimyRJ0vU4CqTwjXl4jMd6cmZTK33Jpk
         lOfCKWR1uvVuOSF6cGRKnlcVUYx8pSuPvnPGbjxg0HcdwAuL2Zz6lDPLFs0D92Fh/ah8
         xPXMthvmKgpOmPZgOBtV7hKeoot61BA26m7q0ZzU7hDnJJLTi3Fm5leM720+3NAldGrY
         m0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694079590; x=1694684390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSn/skXMWf/xa0+iNC5/Gw93hjM5QOQeyldszIVaJcM=;
        b=YSlK76KJicY6AE7ZKPWsorc5eH7DZ/aagHhsyFLrWeQzVLd7QGV8f1J0DwkJxySJWR
         1vgD7ko2Eoz1/nQMIbA413dJPytaG9LqYsIkbu5ACxVR8yB624b/TiFFMOzc0rv0TfzS
         mVnz6zaPwd/TkNRLkKSaPPCL75C3NLKcDJLU5v9XMZmKqabySvVw4EZHQAqdYI9zC/oX
         3QGAnbbYX4+OYH+u4WBR+UK/sUGXT0pgeuKG2rVT/ewRcYeSgUOqAJbnL5ie996mGgKe
         AoWGXIjpv529tsohWWbsbxvESwwipDtDgMBik/0u+p40xa8JZfVJ2CvtwPxI86ZTkBm+
         /fyg==
X-Gm-Message-State: AOJu0Yw6HKO99tZRNtr8Qdq3WFG4PuHrYvc08g+pHMhMQ1PEexKykvvC
	ATOa8LuB3x3SW6ce+80PRlY=
X-Google-Smtp-Source: AGHT+IG1t55SSsZ9IU41gZXp4fEBDaVSYmlggSt5r5GETk7wcr+KmFaGuKy5GVo7hA7HKyZxxIJlPQ==
X-Received: by 2002:ac2:4db5:0:b0:500:b7dc:6c90 with SMTP id h21-20020ac24db5000000b00500b7dc6c90mr4108472lfe.36.1694079590034;
        Thu, 07 Sep 2023 02:39:50 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651204ce00b004fe2de20d88sm3082119lfq.232.2023.09.07.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:39:49 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 7 Sep 2023 11:39:46 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, k-hagio-ab@nec.com,
	lijiang@redhat.com, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZPmaYgsT5EdLVUyO@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_023954_209859_1EF9342C 
X-CRM114-Status: GOOD (  22.75  )
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

On Thu, Sep 07, 2023 at 10:17:39AM +0800, Baoquan He wrote:
> Add Kazu and Lianbo to CC, and kexec mailing list
> 
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Store allocated objects in a separate nodes. A va->va_start
> > address is converted into a correct node where it should
> > be placed and resided. An addr_to_node() function is used
> > to do a proper address conversion to determine a node that
> > contains a VA.
> > 
> > Such approach balances VAs across nodes as a result an access
> > becomes scalable. Number of nodes in a system depends on number
> > of CPUs divided by two. The density factor in this case is 1/2.
> > 
> > Please note:
> > 
> > 1. As of now allocated VAs are bound to a node-0. It means the
> >    patch does not give any difference comparing with a current
> >    behavior;
> > 
> > 2. The global vmap_area_lock, vmap_area_root are removed as there
> >    is no need in it anymore. The vmap_area_list is still kept and
> >    is _empty_. It is exported for a kexec only;
> 
> I haven't taken a test, while accessing all nodes' busy tree to get
> va of the lowest address could severely impact kcore reading efficiency
> on system with many vmap nodes. People doing live debugging via
> /proc/kcore will get a little surprise.
> 
>
> Empty vmap_area_list will break makedumpfile utility, Crash utility
> could be impactd too. I checked makedumpfile code, it relys on
> vmap_area_list to deduce the vmalloc_start value. 
>
It is left part and i hope i fix it in v3. The problem here is
we can not give an opportunity to access to vmap internals from
outside. This is just not correct, i.e. you are not allowed to
access the list directly.

--
Uladzislau Rezki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
