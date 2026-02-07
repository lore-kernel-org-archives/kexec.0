Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF3EEE0AE7
	for <kexec@archiver.kernel.org>; Sat,  7 Feb 2026 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emM03ICtpXPA/lI1nLRfslW4iFBkY1GL7RvYe7XqKRo=; b=RxXWKEgjXJnOx16qCuQ4S5Bzue
	a0pKzx3KCGaKIFfcQXQOxJ3x5aJd1Rt3BZ08BiwnFLx3oUE3onRhg0JPT1jtem8KJrjb0QqTcf3a5
	guTb/tgboP2xZUb/jTzbjrDjOpXsdTBlf5FiWfYqGK+X8zGLd+1w9yeBQ6vqJSaPj4TF817PsiM15
	U02jdsUQrNHkQN8V1EaWCRGAWHBAfUYiklBMD2WaBtbL6qIQGW3CAZaQESgBGDkT+PBQCcAWe3VTR
	q58ZahWMFq2sFnRgYFbSAroq4qrvA/5QMxvQN5xGBK+RWgdCwMuy1cZdNCdf4V068P0Jm56KsHamK
	jhvfQcrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1volzc-0000000CeKJ-3IiR;
	Sat, 07 Feb 2026 17:21:12 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1volzT-0000000CeJU-1MGm
	for kexec@lists.infradead.org;
	Sat, 07 Feb 2026 17:21:06 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-b8845cb580bso269450166b.3
        for <kexec@lists.infradead.org>; Sat, 07 Feb 2026 09:21:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770484861; cv=none;
        d=google.com; s=arc-20240605;
        b=M710Fp7yyktn/pNFJag/PbqdX4ZEyNqD5V7JMi8vDGrbYU1Q+vR4iXVdZquDJnErS5
         MxGbyKo0ZHqUhZUh8MT1+lEQV5AaHLpP5rdmpCkQuybvYvAoZMPG++uQ7fZ2pJL9JYfc
         G2TxAHrJBpYmKX44X8kX4+5f6C81Kueu4b/gco85zcY0UFJZzTKVn0M2gXFM8vSiZXH/
         wtNI7AjpfBD329tRAsclQ8zBhPEYcbaYbiWnygdVBXP8MlmtrM+EKTLjZbs6o1l8cac+
         ZEPjZz+9IdcZjVKQHHm2MS17mjRQeak2oyusWA+Jym84xJYxC1VcobbTJTjDdhOvtLO1
         vP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=emM03ICtpXPA/lI1nLRfslW4iFBkY1GL7RvYe7XqKRo=;
        fh=d4e+xIYouKPcQit6+jcm/JL7k8QOYH/WFN3AOHnTz/E=;
        b=MssCEzKu5Xczkg7T3OUdj0M53g3+Vq4cXFL6dDnMH0c+tCr6sXb+FFNqysEZ7r65BA
         ifs0lCezKJ4BiTPOQK5kgWkBRU8nu/PmJd8jJh9hhZzT4JYzFaDRBd8FZcWZNDEKFPov
         bIG5pVaZKW+06zIp6z6lds8Mw3kzgtPjt7VukMLSxyBxLUWz59mlWTtbrmu2irhuvpHo
         J2rJaSgtGaknHrxGKtHIejMj/8XIlQE+UmUbYNgmRgwf8MDWLVgdU62aKOjVX641ufkN
         GtikJG/cZqr/z9jzoAi3IfaxW3xFm703+GUZiV8r6EGEt255cPJTAB1kkli7G5dt4Slr
         /CPg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1770484861; x=1771089661; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emM03ICtpXPA/lI1nLRfslW4iFBkY1GL7RvYe7XqKRo=;
        b=cT+zmlPzhs+Bbtju3b4jJfaHkEox9kcH+ixSr+awvs1fljG+BnLUPvFzLYFj56XQcp
         qh/hdZ9n5x5etc7FPZwS3HZlytI00E3Ee9tAC6p1GDdUQAu6RORiUjRRN/OZftGbgXbQ
         1MxLszUr7Yy1xdb6fuw1jeFVPzUkmYOVcJlHh/bhcpA1DeHw5l6554QytD+UBOQU1/pc
         AEgWAOsI7cJUjOdKRj8oMHvxUzF6mnkqLClvxEp9PDek2OS1SRKakslUwNFCLdjGZ2qi
         gqeLhVTeuVjy4z+nL8R8mWjTeOXnt7dvJoRw+RiOTiw7D4AlOMS37Y2OLHQmTuTodYTW
         oyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484861; x=1771089661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=emM03ICtpXPA/lI1nLRfslW4iFBkY1GL7RvYe7XqKRo=;
        b=rsiewmBJIQNNFfDm0yZeWIzjfltwrOM7HKemF+r52SThpWkeqjbKBQW3jgyGtXcDLa
         HliXWZZNOn+1SmW2yGO4Yfa2zt4pg2DA1wJBMrHUEDUF7QCiUg947M6Zbmbc5poDj4+I
         /p41/JnD6EdGu/yHy59sLRl+LUOLWdAaXOs88Tyg/Cd7iCW7hnR88OOcJHQDZmfDKzBm
         KaEh7arntiZgb6K9RhHYrueMDdUEGqjAbfD3Vj9BQQ/JS+sCgpQ7bQGT4o4rUuE8Crme
         YR/7n/ZStv/8zL5L1FV97II5jfP8W7gY+2Beb/FneNytAgOq268KX2QRFhDr8IRhIpEe
         wOHA==
X-Forwarded-Encrypted: i=1; AJvYcCUWhSb+Srb5e6pI+Vlcn4MEGOF7+v4xRYwA5TOeSqzzd65+ZUeehZubVzj1XealXgs7GPh++Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwTMaGzVbPEk0EOGaiwX3tZMIoC6J/pc0atOhLIn7N5tOusWV2c
	3BB4ODTXOGVHDtLr3k2AyuASLVQrznxNI1GUaIaOQU1i/qB4/1MFq+SN2edq1AI8A0QI77MfGai
	k8ctOTgQzqL3Ed7Hdvky7OtlzhZqvVn7tHcimsi7nnA==
X-Gm-Gg: AZuq6aIre+vj8OFZ2MCr0kOYcMlvMUSywwNSkWT/KhiPfBDKjIHZOYCdl/FEmrfVEbn
	4rmUMRtuGjXX0ma+eEQNnVpfLIwsmfiCp+gZRkUdZK709x8aiMG30tAfNH8Mdzbf7wMr7fHtUmD
	p4hBTNmjPxWGq6txntDYGnO6teUzSarWA9zToUJNQczqLKglz2ecEFzpCjGZTdy4OIxEWoSQbVs
	lmnC66ecYKUg6hGh3ScBFgm+bfknvfSARDGAUiXU73iPRHx1SmcxfH47lzYPmwnIimRJchyTljZ
	cLsP02Gztn11+j3MAoGREDw6mZiCpL9njrb1qQ==
X-Received: by 2002:a17:907:d716:b0:b86:ea42:f829 with SMTP id
 a640c23a62f3a-b8edf401a61mr395966866b.56.1770484860762; Sat, 07 Feb 2026
 09:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20260206021428.3386442-1-jasonmiu@google.com> <20260206021428.3386442-3-jasonmiu@google.com>
In-Reply-To: <20260206021428.3386442-3-jasonmiu@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 7 Feb 2026 12:20:24 -0500
X-Gm-Features: AZwV_QgzTl4mNxujoLDaf5mTXNHE3H1Ui7pyjHnr-IJSNXlSQjG622HK-ncLm8o
Message-ID: <CA+CK2bBbM9__n-8JbHwi+jUaVYwue0Ro0_z1DPOCXkw5b5=vEA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] kho: Remove finalize state and clients
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_092103_382070_BA5F16E5 
X-CRM114-Status: GOOD (  10.85  )
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

On Thu, Feb 5, 2026 at 9:14=E2=80=AFPM Jason Miu <jasonmiu@google.com> wrot=
e:
>
> Eliminate the `kho_finalize()` function and its associated state from
> the KHO subsystem. The transition to a radix tree for memory tracking
> makes the explicit "finalize" state and its serialization step
> obsolete.
>
> Remove the `kho_finalize()` and `kho_finalized()` APIs and their stub
> implementations. Update KHO client code and the debugfs interface to
> no longer call or depend on the `kho_finalize()` mechanism.
>
> Complete the move towards a stateless KHO, simplifying the overall
> design by removing unnecessary state management.
>
> Signed-off-by: Jason Miu <jasonmiu@google.com>
> ---
>  Documentation/admin-guide/mm/kho.rst        | 53 +++++----------------
>  Documentation/core-api/kho/index.rst        | 12 -----
>  kernel/liveupdate/kexec_handover.c          | 21 +-------
>  kernel/liveupdate/kexec_handover_debugfs.c  | 23 ---------
>  kernel/liveupdate/kexec_handover_internal.h |  3 --
>  kernel/liveupdate/luo_core.c                | 12 +----
>  tools/testing/selftests/kho/init.c          | 20 --------
>  7 files changed, 13 insertions(+), 131 deletions(-)

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

A comment in FLB patch would also need to be updated:
633  * Context: Called from liveupdate_reboot() just before
kho_finalize().
634  */
635 void luo_flb_serialize(void)

But, given that patch has not yet landed, it should be updated
separately, as it is likely this work lands first.

Pasha

