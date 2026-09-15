Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2CBC982C3
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=gIFaEEvuj6YS9+
	V23cBu3to6lgjmrY7nr3fh+xhR8NILbSl+LmGaVHp6YmgHMu2LBbaPgGQyl+bKMHCZrUyT8tW49jn
	SwdYpVqYS4vbVPoP/YnfKeKA0n0u/isYH19hTgCUotOcat1dUhaHJPZHS8svF6N/IJQa/pwO94ubH
	kmgBBkwl2BLKZ3M9Avj39/NwQv8WhCser3x6If+BoI18yvxoo6DMHClnuUQeazmS0lkpjXpJXoflJ
	dYrnsHh9xDKk/duQ3rV9mlOQCsgVkfqeed+5L06vELbwDdFGB91180gK689aKpZPS1zrXZ1E1FpPl
	sb7i3GD5InOLVcRI6ADw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6bWy-0000000802t-40De;
	Tue, 15 Sep 2026 22:21:36 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6bWv-0000000801p-0Icd
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 22:21:34 +0000
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ3fB1152562
	for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux4d0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-46509ab0149so6391310fac.2
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=FDjgEGwqHnSAEHM5p/q7l8U5gL12dPFn0GDyhBBCftcMwQqHoy6sjIUVVIor1BeJS1
         qaykTjturk7w2Pf3bCzD9amHc/VIiL9SSX7LuwBxPugpJ9eq0FkHc6RRZ9mnJMaIMpPx
         2hc4oEOgC26iyG6IoD874joLJFi4Q4AwfzAO3/tqmeCAxKffBGBf8Q0PEBhUPoeXKkIR
         LjGeBQwuG6Yh4Hz/98onvgnyEsQ2ApNdJ0QJ/S7Wi4n86+wxvxOribUoe/j4gUpRayTG
         Lo9hMKA4pxDgFm2p21N8nC2I40WvqjmvHP84iUm1XEN83oP9AlKzqmo8sWn0Q6b2d6Qi
         glsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=ZA6tcgqiAe3KZrIzbFxNBCIBglZmufT53TmGZ+95WDk=;
        b=Fw7M+PgSzDgRPM/kYx90dPjPlnuMdNjcN5r/p+q2F3PwiojFn+KkGq0gXrSfYn9+1A
         c25EAhEAqDeFAF35H7RY5b2YsKvmK2PNz1+vpJ8aUz3B2jo2mpPvYv/Ii86VIvs0l8u2
         VP1FxPdOgmxL6nDWO7vq5d6Pb0S63TCDadOT/EDfLfNIH1+k+gvSumCeZyV7DvNTJxoi
         X1dTYHxePF66/XMYCIn4Tm4RvCN5lfe+ITrjgIX3F5JUt+7qCw/1GwAwN0mOLaZy2qM6
         oW7ZxISMFJorpElPo140sotcZRoBxYy1qiYzSNRlZu0+qBleWmpBj3nJwenTPqeE/0iE
         i1Ew==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=FoTYuFy9GrqqNPcs1ZFGImcDmRL5AF9tq00ISMZkXgyjMZso2cbXZu+IbhHuJEU0BS
         VWv/pOAett/QhTdHkSetFnVbD/ogWtyJKXz5277/WTmhKGdLtFY0HcChI704vPTlMNDr
         02xytw1UeSFN0BKquJSAR4ejrsJUyRfI4KIqytyIdzxV1H8h8VtTx9mlIZrOslCPyzj4
         vjeAgEZdkOzDEdReEGEYOZn+0ldFnOsa2SZdaNXUzMaTX9OjXgy8c1NLh6Jvs0vojiuC
         g+pWBU5OW7qvWZoeP0CfWock+ACnTw0fy4IMEsaT9qYGaG1p7uUXs4dgoI3E5AiBuPoh
         r50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=Fo5vmUMVuIPFcCGgq7jCkcOUwCVBM07dt9AEnBk77s+DpTRVd6YtR7WFQJshFjVaMg
         RTsllzckjbotqWu9RClaY/wv5UhCzi/4LxtZ4SPGYeC7lnjDNmn8YiWSoDCZelayh/b0
         XCOtdU6N+6YXmZWWRJTdz2NkgkOSMTO+4aXnCxFUw0fA3kSWPjaQUT3enlX9LrMJLO3V
         MEOs4Z3gllnYJYRm0V0mcZFcDOZaU51gl+D6ZgQP4KYoMDwv6/3aZfmsDOGdH1xORQK0
         OI2QQzwuoJHR8i9OlnOY4UEZjXfQpMQDsvUaIe6o/3bDWd+30DVXfj+r71G/afDY6iPe
         IspQ==
X-Forwarded-Encrypted: i=1; AKwUvBze7Qddfph2uY2wCC7XiB2Hi5tOL9lyQS9GdqvTpjsPwS7V3fP/riDMXuWdozZSto7EH8txpA==@lists.infradead.org
X-Gm-Message-State: AFuF++nZmTAxlMnehViMLC3Xnby4dybVcxi5m+uwJDBp2JJgYfABjls9
	ztj/GhXSpv6bXLTmx0PkI6VQTZDzs9asq2dxIK1W9lMlIvqXS6nUxBeBJyZu6Blsk7lzYWgRgtM
	X5n96qUPIAuFlJkBC7JhQowm+WwwT4k2bafSg8t3eWn8mbSn7DAxnXkVYz6SkrBW8bpd19lP5vI
	mRZkzR7sQuFkJGTP7AqvuUSBk5PhleJhvySarRXA==
X-Gm-Gg: AYBFou3a743AHIlaQFtEyLO+9oBRUSmQBtpZReLCdXeEZuEk2ySdhK6gOguoedsWMd3
	q59Am84vCrn/mVbAy2cdNW1cIvRDhykTxsOXF67jF2PDPw2dY2Gduf0wD1QThitXDy6DEBS9pv1
	dEteaaD8HBU35lFFNUFeBoR7oePvG7sIiwfeLHynEJePU82JX5cd/AGDTg
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189746fac.2.1789510890836;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfXwwXIB3kiaF/Q
 jleM26Cnbl9lltOUMoRXLli6ZqTqXRayDBrFsz6iD+VZcS6oVtcqoDkWYW2IhQIM9VXvnTYOlH+
 CYYIIS5xl0HEqdFRF70b8mmlYwvryuZyYrzGETTaQmqzyJR09kssBN5ltjAhKZNdK5KKyjUzevg
 qOWf4+fzuD98v+lOXyFdRv2qlLA+rjrb9adV/u25K+N1HNhbT3JAweBeGcFxFGMz93lo3wuB50M
 RoVtAuo5naLU3u22zl+S47poyQkvOmIesLlF2rq/ZoKMczOc2ADTYtVQbtRYXXdXPUQSeiszZDN
 r9S7LQIPr9PvblGYnUFx4IYVXm9nja4uI6M/RVRMikLRvBc+m/NbJRYFDyUBEG2Yj/9z60vsbtE
 JSMH1TDHNSJ0h/a+cyqQ8MdXlzQ1Z1ZwIaM1miL+OCDgK0QqZvbnTvEb0zADcn8fpnt46djFIzp
 7OkYwSJhLB5NAJbJMxg==
X-Proofpoint-ORIG-GUID: Ro1BxNtuyF2o99aKaOAleK2wG676m8Gf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX/q5r2mPSZfXX
 PUYWqdkxJjDxWkMmDisUZBAyQ6IxjqUDLppQdmZD7+Eul5sZrkU++HykfFZMTNuz90Sd/Ofu2Fg
 oLxLRQChdqt8gRcEqEgGhHkjd8US5uw=
X-Proofpoint-GUID: Ro1BxNtuyF2o99aKaOAleK2wG676m8Gf
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150326
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_152133_231722_EAF0E619 
X-CRM114-Status: GOOD (  20.83  )
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R

