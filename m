Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79CBCD98C7
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 03:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZ0G2csavHzp4cLk+LuAsALDwxkSg2fUWirgVu1989w=; b=qQO4FHAAlAyZRp3Dst+5csiLqh
	KKG9LfIkenKFoov3Tk81wKn7t02Nl+V0xc7dm/HBAONumNBrdYmxkLMxT62rzPX3i2A7eB7/OOlg8
	smy0Wh6DBms6fGLuY+EVyNQDnfzfREwNFCR+IV71v8yNYSVq6ip9hvicww+elYdgj4T66HZg4XEaj
	MO9b9aINSy3U2OJCCxqVbC6EmuNr3bvpYVO5D68XMXBNEobvMvOp3jkNGMlbiLdJ3zb3sTcC5jAA/
	omu+AlEdFMb7VBYdbZzsd6rA/oIwdmfhZ9GwPZK4Jd5hdTGZJ5GB/MF/EDADvAPQ2vLo7WrFEdzD7
	kBLPBqAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXsHF-0000000AJKD-2gOn;
	Fri, 12 Jun 2026 03:09:49 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXsHD-0000000AJJ4-2qmf
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 03:09:48 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-8ce9df31840so4468516d6.1
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 20:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781233786; x=1781838586; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ0G2csavHzp4cLk+LuAsALDwxkSg2fUWirgVu1989w=;
        b=IdxFH+Y2gTmhy/IJMQw+HW+e12uVR6m4IlyiHU5TWJKRVotD9DzwXdubfrm16H/n+I
         Ghc5fDQuY2a5MDeDN8XrqcsVWzpNqBo+bRR2eTvcJAeF1QsL1c8hUJ2wQbKQw0vrq6pd
         l97r46J0aLp8maStDer6A33zv2lSduV11F2JLbbfNgv/FuIS23KmaDeZiJzQb+53Lx8H
         tZk6SYjmaNJxS24xpGfST8eu3tirwEMOGTkLjhbIbY/lGFqRU/wVTKFR4ZQllg/3Yf3E
         PEahE3XpO1q6awh/AClYLer81hAovXOqWrgCUx6I6df1s3Ejyzn4Qr6DNhYzmZF3+afW
         AV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781233786; x=1781838586;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZ0G2csavHzp4cLk+LuAsALDwxkSg2fUWirgVu1989w=;
        b=mSjLXSEfcwyZdTKMLyInO8qwuVUclwq//281dP5PZ1fkoQ89SSVNtWuzBOHlArDp/p
         wEBoEzP8zO13B9nI1CpnblH0GpbGwpGHAA3Ddy1H/zdvcZZ0eLTQKe+k9nCPK1VfXgt7
         9ubj6dlALzMPbHtaaWZ+WISIPdZe3DIH2bdTQ2XksOBmYnIok6CdOoYp9Ap9ScHBFoij
         VHcPyTEUSCyNah7UJO+nsil6BBX/Vgaie1L2HBTwT9/xDsjjPX4cYiTdgxx5cJzauvAH
         6CEsHpjyFcQnPlgIb4B8VC2xAVGpmCHyXUxz9kvul3v0sGRbgXYMA0h4fK42eXRbBFNf
         pzYg==
X-Forwarded-Encrypted: i=1; AFNElJ9SN1LNtrkmUGwqpK6DYWkvxQdybY0OPTnCOG4D4oAKKynAv4WPdlN34q7OSRXiPAPyvfBLrA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywm5KMrWZAQGSg6cqB/cqER035CWB/YdVmCFr7nTN6f1bMfjo+4
	qodnat5FTAHof1AY/OhPVw58WI88aJkf+UiZibfvkgk52ywXGisbcGk3w5bY1/cwLqE=
X-Gm-Gg: Acq92OFZf+2CrruyY9b2YKFj0j2ifQDbZPqgpkLw3QQ+vIrmDdJk/3LAbfq9QoJIIED
	bSp3v5Ri6u1NrTNJ1WSmVXsmEsTxO2d5dM8cP6+nz9mRbplvjoZqGcOoxw2MfLI+tIPqi6N4X80
	trn3byJJOP2AhNZzHPokCfCPgqqRmbSW84uCGllIqNA82PrjI9pJUV0f8XBcxqca0I6448OFoGx
	NWils0AaE5xChQKym1ez783dCmYiBMdAON60jlcl0XMByBjyte0zd0Iv42OGjIjnjd7veOVZCDA
	5RJNhfVoDUGo4ojM5DBxZhCn1pUa8rOIbomzGJ865jji5OzzWFoBnQC7iha3saDwOq+9QnfoiNQ
	NfMlGOOQEnRTYa9GMVKcWdjlEcr1a4Oeguiz1gsann45i9jtP2YdbNbMUi/9J8oCsUJksokyBvm
	EmKU1XyXtCm/oizQD6t1u1ndrEUf6/iVO1D2fhE2Ch7X/t6x+UF4Pkdkj0CRbt
X-Received: by 2002:a05:6214:3289:b0:8ce:f900:ad81 with SMTP id 6a1803df08f44-8d32b572637mr18844576d6.9.1781233786246;
        Thu, 11 Jun 2026 20:09:46 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301b271e7sm11280296d6.14.2026.06.11.20.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:09:45 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] selftests/liveupdate: Add helpers to
 preserve/retrieve FDs
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
 tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
 dmatlack@google.com, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20260610230909.876546-3-vipinsh@google.com>
References: <20260610230909.876546-1-vipinsh@google.com>
 <20260610230909.876546-3-vipinsh@google.com>
Date: Fri, 12 Jun 2026 03:09:32 +0000
Message-Id: <178123377287.908199.15268768789704684712.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=oUr477V1FUB4UxQqQUDtbuTlE6dQOuaPh7NG5xJpmQo=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqK3h3ZFEFqasalQR1mWTXPbHrWqj5zJZ2sZ+qu
 k0YSHMMMnmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCait4dwAKCRC7dyhM23N6
 3pDXD/4/VZec2bu52G8fL13M92xQ2xWGdrzvM+V2QWvkWEFb49iIEcbouXWcfg91XHsKLU/MSEt
 me8O8owott8CM2ZL3viFflul8zZKnmgXdUJKI9gQAjYA56k4R+KX2iS3RqZuIzmjcW/G3faV01D
 YJ+1UeIsiiCii+dbZ2tF37OXsTmh3LehoARHEyfLk/DYmRto73KY8LPuzzJpbtmmualo3flen2k
 aVySnAuG9o3IcEUa06/yifHfY/ANedT1zhLn/Y5v+Fzou3SMF9/LRtH4AuRWrNm9gx0tFpT6Pgu
 UKj4WJWUYxC7jY0r4fAcp2xD8wU9GnSx/i88IeQ/NMPFnsbaxXfc+nul7PP2a70Bc8HF+Cm+/gJ
 BT3yuyuR67qfxEWdZOrE26j6ydjzHPysupx8qYTqRzccxr5ZmZ/Wu+kKWW1jROfiGcYZAMzPKzn
 0g9KQhnPw2bUYhSqxIRvnTGDVg/HC2hqAHdu0hclXEV50mgsDPPe306BK12d/pwjKghxXjSsrd1
 TIk5+SUQADrM+Q8vHIme5DhOUZxt6bavVimOPUwmHUn3MmJmYHrFCbAiYv3Itb/luc+OxaUH7dx
 kp2B7CxZ7346MO4AM5DYP9cZ9+zbtnVt1Y1HxOZMy3FI7zcqUBcQTIFqTM2qotcB8cP8QL5nmX3
 dI+E0eClFabbGng==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_200947_750719_9B667370 
X-CRM114-Status: GOOD (  11.19  )
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

On Wed, 10 Jun 2026 16:09:08 -0700, Vipin Sharma <vipinsh@google.com> wrote:
> diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> index 897c200f3845..961a732b541d 100644
> --- a/tools/testing/selftests/liveupdate/lib/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> @@ -78,9 +78,35 @@ int luo_retrieve_session(int luo_fd, const char *name)
>  	return arg.fd;
>  }
>  
> +int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
> +{
> +	struct liveupdate_session_preserve_fd arg = {
> +		.size = sizeof(arg),
> +		.fd = fd,
> +		.token = token,
> +	};
> +
> +	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
> +		return -errno;

We do not return positive values on success either, so !ioctl() would 
be a tighter check, but < 0 is also acceptable.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

