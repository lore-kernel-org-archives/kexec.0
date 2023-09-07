Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A742EE14D9
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E5QBRcFpSfyO537IkhXkW+sEcFoBaSf8Spr5Bj0gwuk=; b=1d4eujsi/QVtTh
	dOvdzOjfp1Dh4q5CNwJZh9pHAM3Fn7zkaTLpTy+n4VK8N6UUG9uSCYH2GzbVzy1DeO2WiGHokq2iy
	pc5rBef1X+mAntyirHSB1Nj33mEQBVbVf9CDDVEc51iWpqcCnnxtDaY8g3hm+wrukxpdx1xdao2ls
	bHjlUcxIKfw42SuOlStyCrlgTSYne2lFx7ul9zHsY8SiAsdzUFZ62t6qw7orCMI9kuT/koxAW1Rwb
	KpMEEcjZD2ONw12JhEXZ1UXmc4K++9eHHSVvXi5g6UO3QrakJBc+x2g2nHAAmtmWtozZjdt46YI3z
	V/UAZmixdRqA8vtOo8dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBVE-00BhTw-0S;
	Thu, 07 Sep 2023 09:40:44 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBVB-00BhTK-0q
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 09:40:42 +0000
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502153ae36cso1128262e87.3
        for <kexec@lists.infradead.org>; Thu, 07 Sep 2023 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694079639; x=1694684439; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2fdKFR8q9uEXLNSeU9tuN4gH8iEvFyeK5eSCmXl3rY=;
        b=DzOJCkhRVnD5xl53L7CgEZUTPx1kVnwbw1Yy1DJFEJMxLt4T6nfReEDx+vpfGbkt8W
         TpR041j1E6QQ1oErjlmtymKqsleAsmTKxv6Kmyqmq55+YthreqkugaxLv2/igj94m4Gb
         tyinwtSRgkGWaTKYCe5f4ZfrVs5L6tQtG7nYM04hkR7BcYeO0fYqgsdhtytK76RmWboZ
         FYk6qPLbRW6HK4WmxIMY93qBp8Ak4hkk4gIAH39RCH1LVawbPeHmIao3JQcBxSa2BlXg
         liNceAlrD2Y6Y9K050Cl/2RBDGGLGLsprs4LLmKvLw7G41q/uh/8x9BTH+73FDS+KKL/
         Sa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694079639; x=1694684439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2fdKFR8q9uEXLNSeU9tuN4gH8iEvFyeK5eSCmXl3rY=;
        b=TyeUl/IDfHd8D5J7fIcLzjPiHauiOYH77fEBaS1H2rQEBxrLRw4CoJofxf5+Xaxi05
         uohw9MYpm7fYxnD5PuGyt8QTyUA8iL/7hqdGY9zvlETTKnBw1w0NS6t706D8DXCXPx3E
         g8Xpha7INFUZXWp1ykkkhPOqH/9PWy9LiqI2HAqDy4yIs7bGWDQYTU9lrb5jS4zw0bgv
         mktf1QoedUcNiPJwlKHTi0tyBLGqsxtiN4+GwetAXEBYaQfPg3JO3YUHZaX+DpCKxalj
         P+v1WZe/0tiHVInB39B1Gk5z5v/GMefoBdoBqX7d5SSjyQvlqZkUAk6PhWD3/e24J6wO
         Elqg==
X-Gm-Message-State: AOJu0YyH8m/salXWXzS1RGLo45y6p5QDYHOKfSMHabHOq8moj0eRf3Ws
	3Q3gqR3qnFyCIb6T6UguUFY=
X-Google-Smtp-Source: AGHT+IGnVUxgJvZMlPBtKyIiXEz0zQ/L77txjqDYDTh1Sa3UGxaMrwFpLFqcHn1w07E0rmK4dukubA==
X-Received: by 2002:ac2:52ab:0:b0:500:5d5c:ecc9 with SMTP id r11-20020ac252ab000000b005005d5cecc9mr4043445lfm.62.1694079639175;
        Thu, 07 Sep 2023 02:40:39 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id t16-20020a192d50000000b00501c6d78f11sm597800lft.298.2023.09.07.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:40:38 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 7 Sep 2023 11:40:36 +0200
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
Message-ID: <ZPmalB+hfaxAZIcw@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
 <ZPmZ/8CLpKHEZvQY@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZPmZ/8CLpKHEZvQY@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_024041_338416_9DD34965 
X-CRM114-Status: GOOD (  28.00  )
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

On Thu, Sep 07, 2023 at 05:38:07PM +0800, Baoquan He wrote:
> On 09/07/23 at 10:17am, Baoquan He wrote:
> > Add Kazu and Lianbo to CC, and kexec mailing list
> > 
> > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > Store allocated objects in a separate nodes. A va->va_start
> > > address is converted into a correct node where it should
> > > be placed and resided. An addr_to_node() function is used
> > > to do a proper address conversion to determine a node that
> > > contains a VA.
> > > 
> > > Such approach balances VAs across nodes as a result an access
> > > becomes scalable. Number of nodes in a system depends on number
> > > of CPUs divided by two. The density factor in this case is 1/2.
> > > 
> > > Please note:
> > > 
> > > 1. As of now allocated VAs are bound to a node-0. It means the
> > >    patch does not give any difference comparing with a current
> > >    behavior;
> > > 
> > > 2. The global vmap_area_lock, vmap_area_root are removed as there
> > >    is no need in it anymore. The vmap_area_list is still kept and
> > >    is _empty_. It is exported for a kexec only;
> > 
> > I haven't taken a test, while accessing all nodes' busy tree to get
> > va of the lowest address could severely impact kcore reading efficiency
> > on system with many vmap nodes. People doing live debugging via
> > /proc/kcore will get a little surprise.
> > 
> > Empty vmap_area_list will break makedumpfile utility, Crash utility
> > could be impactd too. I checked makedumpfile code, it relys on
> > vmap_area_list to deduce the vmalloc_start value. 
> 
> Except of the empty vmap_area_list, this patch looks good to me.
> 
> We may need think of another way to export the vmalloc_start value or
> deduce it in makedumpfile/Crash utility. And then remove the useless
> vmap_area_list. I am not sure if we should remove vmap_area_list in this
> patch because the empty value will cause breakage anyway. Otherwise,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thanks for the review!

--
Uladzislau Rezki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
