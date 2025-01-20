Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DC9C02181
	for <kexec@archiver.kernel.org>; Mon, 20 Jan 2025 20:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBGTlpktnfLnmWiv2pwLE8GsviTICX8GzHtpXO/5y+Q=; b=jNrLpCSloqg7MHXGOZgBFKVaHe
	hv1qf2871YKpBXPe2XB+H2uZwqzUb7QkFXP1Q5xm8mLVqNTnc2rlUU/Xsv3xz21AUa5NyT5q0iYjq
	z4LqjWUkTx6AdsKC8ABQqQ1RSEcLkaFPUjCLmLXKsETmPVz4UwqUPLNiz/JbKW0S332R8PlQqu2HD
	RthUGI8t+lCn+lfJcFMFbu3VErJorp6As4BIvTKvuIBCC0x++wCi3d5Py29xULT0liWl50/75uxJt
	Px1ZbwDhq+cUqjntSMyapkLgzNEIX/iuNUtrrepaZzdnJi/1/TOuudvGKB0dItEdfk4GYglT94JUA
	0ZQfL0pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZyGS-00000006OLE-0LRe;
	Mon, 20 Jan 2025 20:20:52 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZyGP-00000006OKA-3Gx5
	for kexec@lists.infradead.org;
	Mon, 20 Jan 2025 20:20:51 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-215740b7fb8so300005ad.0
        for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 12:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737404449; x=1738009249; darn=lists.infradead.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBGTlpktnfLnmWiv2pwLE8GsviTICX8GzHtpXO/5y+Q=;
        b=XE/QBm/leQ3L+Utehs83vhr+f/q9CwwHkHqLfA+/6jDg4JdFs03HBodN+q5Z0QerOg
         5RQMVhnLHGAJxQ4+sdLhrKQvdV5hWHvW+io2IVJ2MFRQL4Fhqr1UwoCVCcls28MYpa/g
         Yw5ErYj1sZ2P7GPe3IE8g5VBkprkpXywzF5aZ64Am3nkYuW6e4hetSanjANBWs9o2En7
         vio++S1vqCM7o0PtOdEfJ3TM04cyFBfu80OoC5wiNm8cOqFOw+Aojoxi//ekAdt4EB2I
         PJ9DCjZyydK5WKmhwzJFDe/AO/PtTO1Ujun0R+CTilJqq5KsDcNXRL7Aj1Dp9LdsUAGq
         QXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737404449; x=1738009249;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBGTlpktnfLnmWiv2pwLE8GsviTICX8GzHtpXO/5y+Q=;
        b=aTv65x3ZVGvPrNKYEElZNSgjr/mB9lrFdUZQsJNgx7WblWlnY/kjIUIkZd7oZhWZBB
         KEF7h7zQSIgGYY7mF2ULlBlhn4u9y8UlcQb2jBQUPRCMK0fbSCJPoju1gosxIy+4+53/
         EhpebRcjf5av0UiQZ6TQKBZyEuBR19f9KT40fKAIPWzUih2lJqRmyL6yFKmkK36UfUm7
         BM9XKF7/HLekGQeVIuplzuVqXlYarO/OTQWjazstwuWWh5AJVymBKzAFw4bWR3OIqUh+
         YOiaw6kBiU8RwAHU4LNPTkeYb0PNh++08a17+n87LN6Qf1B204uAuz+ZRro04dEX5att
         S0RA==
X-Forwarded-Encrypted: i=1; AJvYcCVVF1g3CxsKjjWNjnOLSdtTZSKsNlZ6XgwKCSlbQ5qDyVjzow500dNO/cskEuss9TrhNiUzAw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaOPTvbboF4FTzSdZC/b10UGklOvTnrsRC4IwJ3LTkcltmBqq+
	usxL+JFV2JnzDN69RwvNX0H9kNzDlNgBgM1eIBwaVNaRsQKCiKHw5yYHNNrU5g==
X-Gm-Gg: ASbGncsJKLMPbx7EJ87IKsAltt8D9trFj0E5w1FpdDWilTZP+RVh2SFnili5Q2hLlvl
	L+fSjVuxOhyBrQV0zORPWfehNwX0LT0iZAVhv8GTMkzEiPa2934LS+nag3NZwHQloBkaiJspCRw
	SliHu6U1QNjjg7kBuBTCUYAamfSGVNLtAGRBVBPkA2wCfV0rRbpBFK/h5tmzUQUmcCr+IqsjB4k
	XESvOZhoyRoxZOxDtytKOZDfu43VVuH8oRooftDbtMguChapvpaTqLcD+laCodtK9TYS5r4PRGC
	kmSWXHsXVfm2uJrEPLp+4J6y
X-Google-Smtp-Source: AGHT+IEd1ApI/OQZNmQfRLrN8Eck/MuZnrlsi5Pe9zFkGWjJKyPOP67Jh9+eGUR6plDu9H9eHXwsYA==
X-Received: by 2002:a17:903:2cd:b0:215:7ced:9d67 with SMTP id d9443c01a7336-21c5d602c71mr4537565ad.24.1737404448773;
        Mon, 20 Jan 2025 12:20:48 -0800 (PST)
Received: from [2620:0:1008:15:1620:99d0:894d:83f7] ([2620:0:1008:15:1620:99d0:894d:83f7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aab358fc6d8sm4112886a12.51.2025.01.20.12.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 12:20:48 -0800 (PST)
Date: Mon, 20 Jan 2025 12:20:47 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: James Gowans <jgowans@amazon.com>, Dave Hansen <dave.hansen@intel.com>, 
    Matthew Wilcox <willy@infradead.org>, Pasha Tatashin <tatashin@google.com>, 
    Alexander Graf <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, 
    Jason Gunthorpe <jgg@nvidia.com>, Frank van der Linden <fvdl@google.com>, 
    Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
    Junaid Shahid <junaids@google.com>, 
    Vishal Annapurve <vannapurve@google.com>
cc: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
    Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org, 
    kexec@lists.infradead.org
Subject: Re: [Feedback Needed] Hypervisor live update biweekly meeting time
In-Reply-To: <2908e4ab-abc4-ddd0-b191-fe820856cfb4@google.com>
Message-ID: <1ed0e895-bc74-897d-d9a0-23d10a031cde@google.com>
References: <2908e4ab-abc4-ddd0-b191-fe820856cfb4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_122049_817127_4894FE43 
X-CRM114-Status: GOOD (  17.10  )
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

On Sun, 12 Jan 2025, David Rientjes wrote:

> Hi all,
> 
> Following up from discussions at the end of last year on two topics from 
> the Linux MM Alignment Sessions, memory persistence across kexec[1] and 
> Kexec Hand-Off (KHO)[2], we'd like to start up a biweekly series dedicated 
> to this topic to accelerate alignment and progress.
> 
> We discussed this in-session as a mechanism to accelerate discussion on 
> pertinent topics as well as get regular status updates on progress.  This 
> obviously does *not* replace upstream discussion on the mailing list, but 
> is rather meant to accelerate it.  Regular summaries for each session will 
> continue to be posted on linux-mm and kexec mailing lists.
> 
> Per the attendees on the Cc list, the ideal time is likely biweekly on 
> Mondays at 8:00-9:00am PST (UTC-8).  Since next Monday is a holiday in the 
> United States, we'd start Monday, January 27 (this will also avoid the 
> holiday in February).
> 
> I'm planning on inviting everybody on the To and Cc lists of this email.  
> If you are also interested in attending, please email me *privately* so I 
> can add you to the invite and shared drive.  If you are listed and are not 
> interested in attending, same thing :)
> 

Quick update on this, the calendar invites have gone out for the 
Hypervisor Live Update biweekly to everybody on the To and Cc lists of 
this email.

If you are also interested in attending, please email me privately and 
I'll add your email address to the invite and shared drive.

Summaries of all discussions will be sent to linux-mm@kvack.org and 
kexec@lists.infradead.org.

Thanks!

