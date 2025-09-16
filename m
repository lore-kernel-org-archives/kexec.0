Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E24CAC59D
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=; b=eLw/zkiXzX7yKNDpSWgxU7iJ/O
	giTfxc+aEOdjse9ktHSk9eKVynbp3IbjYgib+A60/zsvNC3EWjb5/3kCBvT1YrRZhav8zHlNkfLKt
	GQVJECeBCCuF83NNBIX6dHfF5PEfSxqu0CB3vcQU9+/aq8KEmsvLW/8sB1b4C1sH0xyp+Kl9F3TDh
	d0i6F9bNB/miQFHMwx3Qz9I2OcYzTMXMaX2+daySEmUmu4XVYRnYRncZnnXpqlPrJswkve9JdjIqd
	Zvwj2gIs+4+jsNkdvs1Cd71iSgMJs9gOIQGOD4b1vOjgZv292WIXj/WdbNciFn+uIBz+3BGPPw/h9
	r2kBSVoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybyj-00000008xgi-2F9h;
	Tue, 16 Sep 2025 20:08:41 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyTlv-00000007eqJ-2Ei5
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 11:22:56 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b04ba3de760so673399966b.0
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021774; x=1758626574; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=;
        b=BO3NsjwHYs/zCQV0Knz7sTP7VdKe7ihAX3cO9V5LP5VWJERqhnXItnpWfKlXkA/FKu
         UGmXU0rE0YmdBSgT9TXpOZiBdPI2ddQYnt0ivl3nO4OS4oa+aCtmxNs8scH7QRStlkE3
         aNK3ZfS0S61d2IFsLIiaL5G0JrtU1ac9tg2nBE9i0vG0SgIp2xrJVh50uy4/pC9yVUy+
         L250uQpRn3Sk/7mvevKQfomhpFZ4cMJ4C8ARaZyv8xxN1AU0mgiw+RaDGHMZ0pNsXw1J
         aewcdUElV/2WG6t0yYM6VuHKw+F8Og0ejUNiJAkfA87YnWW0SxWfC7pDfswy0IjmJ0Qy
         Z0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021774; x=1758626574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=;
        b=eSBpj7KgQGwLMuoEyLCud0fcfgBSh2RDxbCiIlAgB/Fb2Y04OcEzpzNICHl6SUiGpB
         okGZMuCGSecz7ddWdkQ+NgcDouAG0alAEGt1nKqpYFdwINhCYBJIMD3aDrMivZm2/ZdL
         N7SiPn1DXj08dvuonKoyAPDBihVRBYWJ8IIEds2zyPKw2r3WX/2jrwUoc19ea8vUS0PM
         Jh6HTBLiPfdNtZotmttm3jfdyDZt0cATBwckUUa65fAThtYFZJF/1JMksUu8wKuQ50jT
         tD99YosPolarPvVjmhwiI2M8g+yTKOlDmoLekXklJO5a7Y8ADXPLM6wYGsbeKmg19I77
         N94g==
X-Forwarded-Encrypted: i=1; AJvYcCVrQYYSpU7vdCb58GpWgT3QVNeiIx8CZWqbS5AGLcKUjOFgylqPMB4owX6rqB/AXI/tqNq8kg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwuvtvutLWDC38WJD36oXzGhuebNeVCvv2eR6WJeYRJ966JtdPN
	nu7UCFVl9BpddhgNziZsbNRmjT/2mzgaoWltER43hO3IYyBOGYDCn0VctCe8AThelcI=
X-Gm-Gg: ASbGncuFK7zrbsKSCn1M79PlaDBWJyF8+iCc0OEmzsKICrmF1EDBvimQXPSSSZjRcwD
	GrqK/17kMyKlporMVPNCc8gUXx/L+sJrEJVsBqexJIx3IEE9qxkrSSqSJjBHKlfAh5Nz4lDEJ5f
	bGdAffMjeVcUlHlBjjjNlRgYM/93r90xx1RyDXWsh/2gzdg8KCHmCYgE8BuWoeDIuJ3gj0DNKNN
	0slnjDvGCozA70JQcDzktiMzt4KEJmfAN6Q0h6ycdv9xWplCVmhS/C1rlz4ND9yyfks8wsHvu9A
	24aXRE5Km6R3p/BFY1TSq1qS0iE6/iFamFLTpP8osz9fF7sX9+3kGHv3kJJ+LbPqdrTzQm/8Vuk
	nIEfIjJU8mIgPRDB6K7uJmRiNLl0epnYiqTpcZj7Qp1ay4wa9mfg=
X-Google-Smtp-Source: AGHT+IHgksZmCXWo+aWrU2puhznGEL5CDcY5xl+DcR6ldtoPz+TwMIqHuYXw60VG60pLkMPaI+rleg==
X-Received: by 2002:a17:907:daa:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-b07c3574efemr1811450966b.17.1758021773565;
        Tue, 16 Sep 2025 04:22:53 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2098sm1157083666b.74.2025.09.16.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:22:53 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:22:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Subject: Re: [PATCH v2 7/9] panic/printk: replace this_cpu_in_panic() with
 panic_on_this_cpu()
Message-ID: <aMlIi9cT7xiYWo29@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-8-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-8-wangjinchao600@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_042255_589069_E6A2074A 
X-CRM114-Status: GOOD (  10.15  )
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:07:58 -0700
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
Cc: Sravan Kumar Gundu <sravankumarlpu@gmail.com>, linux-fbdev@vger.kernel.org, Kees Cook <kees@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, Yicong Yang <yangyicong@hisilicon.com>, Zsolt Kajtar <soci@c64.rulez.org>, linux-hardening@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, Max Kellermann <max.kellermann@ionos.com>, John Ogness <john.ogness@linutronix.de>, Baoquan He <bhe@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Helge Deller <deller@gmx.de>, Joel Granados <joel.granados@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Nam Cao <namcao@linutronix.de>, Qianqiang Liu <qianqiang.liu@163.com>, Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Luo Gengkun <luogengkun@huaweicloud.com>, Feng Tang <feng.tang@linux.alibaba.com>, Shixiong Ou <oushixiong@kylinos.cn>, Anna Schumaker <anna.schumaker@oracle.com>, Tony Luck <tony.luck@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>, kexec@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Li Huafei <lihuafei1@huawei.com>, linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon 2025-08-25 10:29:35, Jinchao Wang wrote:
> The helper this_cpu_in_panic() duplicated logic already provided by
> panic_on_this_cpu().
> 
> Remove this_cpu_in_panic() and switch all users to panic_on_this_cpu().
> 
> This simplifies the code and avoids having two helpers for the same check.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

It is great that the helper functions were consolidated and moved
from printk to panic code.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

