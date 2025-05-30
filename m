Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7244AC5B552
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 09:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBoLdDgTszvKcfmqb+9eLVb2IyFbtgcQV42UVzWvyCE=; b=xuetEbFFnG9e+LlCURtLNksWkL
	xNrx+o9+++iZ3GwMe+ycdqjjQMoI3Db3sAZ8uzVhx9s2j2Ewn7x4SCDu5Re75503ni1C3aJKxhO0t
	IdVfmXokTyMqUWIvbSbeLR8yD1E8mYXMlD50UVfLbJUsexRTN0/fMat4qmnDK46jw97eHR1/WKuOZ
	Hgpza5KD5saTewvYmbRplxLAAVqn3RVlSc6yF1+yrnl3j7lEad1yjGBW4qqt8fGMdON99r+2XHbgZ
	LstA2w0dEGZeuK1j5s+OcKhkraJqPePG7G2orea450eTiMIZQTB+E6OFXMEa/p+7osgpJ2FPAta+k
	Rb9JfgRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKvpq-000000005d0-04eM;
	Fri, 30 May 2025 09:15:30 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKviD-000000004mN-2AIH
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 09:07:38 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so4376045e9.0
        for <kexec@lists.infradead.org>; Fri, 30 May 2025 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748596056; x=1749200856; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBoLdDgTszvKcfmqb+9eLVb2IyFbtgcQV42UVzWvyCE=;
        b=c7ao6A6q3Y9Y70dG4WBN8M7pgw+k94GCPM50c4GV4bXdT33a5CncBVdaPGPoY99sRF
         cWvSWmkgyAnYxSSHeO2ezI6ugTIVY/Hbj5FDwRHBy0nhZkkh4fvQogMollxKN1T7r0qG
         k5XqTTFMZvgpD+JRl5q8kft/wH+TUFW5NBnlUPMzqt/MEQ3lQkZuaepOoHIxESz+kJ1Y
         xeF1U1XsZXaBQz3UpweHKrz67Y931QaeGGrQUIMShYuY76zMAkwps5H/ICtPr7O2v0Yi
         +j2oD2eNgSWale0X3lBHpC978H6Xl0E9/jC10qq74xKn/uBjW/2tkzLA2I/SVi2JSl+b
         lKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748596056; x=1749200856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBoLdDgTszvKcfmqb+9eLVb2IyFbtgcQV42UVzWvyCE=;
        b=QJi00vCWVIupyArMkMC0lcjgofEW1htHG7zS/299dC6gYZFnfLGlO1/Jy/y8Z3MDuK
         n2+nDK5mLIDIdPhOkVgYe+KvZ5gvM2ntNlBKbxwsiF0GHULD/6YWMKViDGUhQBkc3JNG
         2ETc+pnRUICVQCZhFL6C8FNA0p4oYpillqjr4u9YK+1ELbOFyx7THv3VxuprM3rzjqIN
         j05Pqc4He0iddFAz3r+IaectQFjIcUTrFrAbbvaK97kA82Pe81lHKkzGxlcaPnA5Cxer
         XI7FrgJJUGTlt8DccbXKCY0PIu0Co6VT9MTZo4tcJw0uelW17pB3ojKMAX49Ir35z5KX
         nxwg==
X-Forwarded-Encrypted: i=1; AJvYcCUuUoy7/MPJgKVoPK36SXRG+JeUlrp52CJplWCx4TWwnfj5VGXJM91sNhMr9eECbTbABGmbOA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyrDlliEZwTEiYyREF4kZ0NVal3PxuhdFvcr4ULexdgdrNkQSgn
	OXiKbLrgavDqkg1uR07/rCHTa62qa/b2Nfj7nAQD97nEf67zq3jJ4nnC0H7kvY8MhVM=
X-Gm-Gg: ASbGncvpTv1LgZQvXHoWrPiGC9HH2KpDX0jfrqqNtAtcJM27pFxBlY15lW+MUEo4fz9
	LXlkoTRPqhvMU9iFeH+AhJpezhDmCic6mUKbpDHM2dlZ2FQOLPHLDFCyQ2YuC967sfUsC/RNMC1
	CFFpgdjSvQdrjGW49DR94JB48NMJevzYxs79IxlaXouQts8CcPxNCkHOZrjojgfKjdUT4IcxFzS
	N+pHO7E6G05gGvaHC4lLpRZ5xm0rguoqW/O/F+iTNMGUkkUWoHSO7UtR2iFR0nrujFGDCK4X38g
	kzf96h/3Snl0KFOHuEBbmD1jxxDGNuEjiOpDkGSEpwdZH639hha/dYNjcpEnLNt43vuuoS15/13
	88RilAvSW8A==
X-Google-Smtp-Source: AGHT+IEqyiCNMlturDlCUFIxx4iLoEZ93zytjOhgqluhNHe7ssc/aGQOO2bx+VoGalmOEoFz61oKqg==
X-Received: by 2002:a05:600c:34cd:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-450d69abea4mr18955185e9.0.1748596055760;
        Fri, 30 May 2025 02:07:35 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7f1b0a4sm12546965e9.0.2025.05.30.02.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 02:07:35 -0700 (PDT)
Date: Fri, 30 May 2025 11:07:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aDl1ViMpK_6q_z06@tiehlicka>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
 <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
 <aDlsF5tAcUxo4VgT@tiehlicka>
 <e0f7fc1e-2227-4c6b-985a-34a697a52679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f7fc1e-2227-4c6b-985a-34a697a52679@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_020737_557695_6BFD9813 
X-CRM114-Status: GOOD (  12.27  )
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

On Fri 30-05-25 10:39:39, David Hildenbrand wrote:
> On 30.05.25 10:28, Michal Hocko wrote:
[...]
> > All that being said I would go with an additional parameter to the
> > kdump cma setup - e.g. cma_sane_dma that would skip waiting and use 10s
> > otherwise. That would make the optimized behavior opt in, we do not need
> > to support all sorts of timeouts and also learn if this is not
> > sufficient.
> > 
> > Makes sense?
> 
> Just so I understand correctly, you mean extending the "crashkernel=" option
> with a boolean parameter? If set, e.g., wait 1s, otherwise magic number 10?

crashkernel=1G,cma,cma_sane_dma # no wait on transition
crashkernel=1G,cma # wait on transition with e.g. 10s timeout
-- 
Michal Hocko
SUSE Labs

