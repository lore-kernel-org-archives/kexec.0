Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FA1EA71A1
	for <kexec@archiver.kernel.org>; Sun, 19 Apr 2026 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZlSIGpsvAcR+BL/B11ZZ19gh3Bd1IZc5Q5ftal4be4=; b=mTVMoalO3ZRCr6pjEicq1xUfEf
	XfDDOCq0xwO5If7rdtCg83xAOCtks+B8+cBCfOGwM2/1B5be39KBbew9C5iUjY4/+r7LnoWyYk8YT
	qsV7cvBc+iuAmRrx+lALRKwbueXHKYhupE+ouws006aiLZ9YaiAUAVlCHrh+xtq6r7GbuTe1KBKwo
	3Ln0D3qQFx8uI5xBGczccak1Y2GqTAR1mlnZ5hSwXwUu9wQQL+JkQ7433eT/veDygqR2yh35aS9eq
	gj86R9ZtRhk/m+cEFyNLuhpyBGQGZp40I6fx7YCYJ5TeVHQTq6rFAIvVzGQ06dX1E01OY1vPsWIP4
	tPmkhiSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wETjM-00000005s9F-0IGP;
	Sun, 19 Apr 2026 15:06:40 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wETjI-00000005s8t-1gw9
	for kexec@lists.infradead.org;
	Sun, 19 Apr 2026 15:06:37 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-506aa68065eso18535971cf.1
        for <kexec@lists.infradead.org>; Sun, 19 Apr 2026 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776611194; x=1777215994; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZlSIGpsvAcR+BL/B11ZZ19gh3Bd1IZc5Q5ftal4be4=;
        b=N0eXIsJkbe74lPy8TDJwR0xDwh8NOru31Y2b7SAwmU6KPUceb8KY38dGr4g5dU46n0
         TMpCbvXG1gwqRXxpotcIJvdyterSgt9yavbs4cOHMlMcuR/MVS460pttC7DP2u7vo0+x
         USM1JhiZl4cEhzCKBvShWTon6N9V0ZsbAAWlg99BHXVRkCMYajRznMoFSsGSNk2DocKl
         BIL/zzS20acljci2y6eoZ/JTX3lwzXYoPph7cPtaNbjLyFusq1KZyT2sF9MiZ7rfwe4w
         LUB3NXVzGPqvQYZGlAJp+3ArzmwWqqkf4HuNFUCPeIjdOp9ws0bb1YMaJumVUqATKfGP
         +9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776611194; x=1777215994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZlSIGpsvAcR+BL/B11ZZ19gh3Bd1IZc5Q5ftal4be4=;
        b=ijqhdxLj/aFAwSNXVGvb5obf9Jiu0H8OQqERiLnmtr7Pm6Y4VRPixzXiUFVE8h0g3W
         me849K02Yz65jrGY0z55LyJ9sYLFEPG5JSlMNqV83LY245EFWyJDT83XVy3iW2HpB0pB
         VoFP3NA4XLf96eJduYMD/3omjShdy/67sTq2w3vImZPPo/3HbLSD4oYspjzjrdXah0ae
         1TdlmmB71IyiBibrYA1LxbpuMVkPWcc7B/cDNGk+LXW0wrx8DmRYoO69JnPRoFDeKEuw
         vFgL0j9rdikqCSAgf/0DcW4Ic1yLpxtm4ZO39VRvzb+mTueaoHx/NK+r4s/prwFj7cFu
         aqEg==
X-Gm-Message-State: AOJu0YyXRnaCAWPXLJ07ebRBQOrFjjyKDTNvTaugjUIXb46/Ik9KB2Kk
	l2xfsHG6zl9IXcD8FCPltCb4qbz/LocFcz6wRQdmZk/RFw1VrUuV4UI7cDd/J02uh7M=
X-Gm-Gg: AeBDiesaDubDf/OOZ04mKV4KXxsl6N6wWqtWbXIIvLysKD9hpL5nBOIeGAVecKb9QBw
	2DBhANyja0gjQH3uz5872/I/uL+9JH7kb/0u6HY6KpX8Gm/mX/UcRIvOTNumslkmwh6IbFKCHk7
	LFIhP6RW4hAVxCVe4SOOyscKNArYecme+f78vmAH7jOXZwKcXpLeINScIDklFuvvnmhwYUH3g8K
	26SHVypZhlAUbuXWdetqZkRXnAVRQ8LG6ue+QX5odhr2E9ohwvZE+ZmqfsG4pBGJ/1kyfw7EGE8
	2Ai4d3wAf8tJQhgpMfbnmFc1Yq09DF/8GUsu3JjyzMWgsAzuaWRRZt74TznYpIKm6iUS9XDt5Sl
	YQLH2Wp8JjI//aBxWK2MMV1m1d3RwGjEbYxKo36ZyrzyxDqkKrRnDFkZpA/HvDA5x0O9d2SncL/
	d70npe9cTqWGt67neyiAyMAlY522YULUfsnpGu+gp2Spkhd603P5/FmVGxhbBKfY7WkqoGt8c=
X-Received: by 2002:ac8:598c:0:b0:50b:7113:7170 with SMTP id d75a77b69052e-50e36c3513cmr165474591cf.39.1776611194283;
        Sun, 19 Apr 2026 08:06:34 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e5d5ecffdsm2643201cf.29.2026.04.19.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 08:06:33 -0700 (PDT)
Date: Sun, 19 Apr 2026 15:06:31 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/6] liveupdate: reject
 LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
Message-ID: <vgyxmjxbquino2fc6hfbzcp6nc7vdwgf3d54tngwb6j2m377ol@q7hjmecgm4dq>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-2-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418163358.2304490-2-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260419_080636_498378_BABA7B2D 
X-CRM114-Status: UNSURE (   6.19  )
X-CRM114-Notice: Please train this message.
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

On 04-18 17:28, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> A session name must not be an empty string, and must not exceed the
> maximum size define in the uapi header, including null termination.
> 
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

