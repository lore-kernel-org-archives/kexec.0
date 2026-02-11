Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6046ECD6D6
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 19:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mtFHLX3t7mFwB3FyF/7aRQrPd6PJdO/LGE1y0kBPp6M=; b=b+U3eRtWc62FXxP0MLLPxpiEy9
	eR4il0DJKtQAl6etZrkNZNx4uV080pqMzCgiWYfDrv4BhYNlEVfGCRicc0KzjgvyeRbj3aFKyhSdA
	QVuI6lhyCG+6hpU+qYGLSJtGWHcjX/hDMDK6OVpn7XCwAsyIeFTWWAJscau253rsfUWNID8EzRH1e
	suBFDVmZZncKDTBnfqOwziWKKHcl1F+0PR1Az0UJuSW03g1QNeEPjEyOLEuys0Nrv3yWYZwyzlw1i
	mBCnoq562Nylj7XQt7uSrq+2Xa4jqazdfOgmP5gpUDCKCGwrYR4qtE2KSu2v+Y3SGTPAloGaHoFtC
	6EqmLCnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqG4p-00000000zge-2Com;
	Wed, 11 Feb 2026 19:40:43 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqG4n-00000000zgJ-1Tae
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 19:40:42 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so415428766b.2
        for <kexec@lists.infradead.org>; Wed, 11 Feb 2026 11:40:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770838838; cv=none;
        d=google.com; s=arc-20240605;
        b=MHImP57Jpv+uaLi03yP7BMqabaxulbTWfLI2gNZYyTz7HIOkLYYz2Dd4UiLef0zozX
         /uICLv3npyLvl0X0NZtXBv9viJoMtrnHZetK1h98Fl+nJjhDnwPzuZS3Tx2NKtqrE47l
         rz1HUMM+K5ZZl47ZXn8OHpR0k//RDoE3te1tfpE2JkNSxcPebhWUCqOuJMmnnzfhVBg/
         ynlu/7KuP2vXKFHvL0odj1miPJHJ0uKV7UnjEl5Y9swn5MGEDzMwpp3TXiCp59MWryoO
         D0TsVkWwdFQcnT5RpVDseDItoUOCULwpaHDQhgZkXrHRfK271hhBrDFCBdt5rN+RaYAP
         zYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mtFHLX3t7mFwB3FyF/7aRQrPd6PJdO/LGE1y0kBPp6M=;
        fh=JJOJMruocd207LZUQsQbgEZIr3sRG7rZAa1wc3RpINU=;
        b=WWxucP51uzQLE/7La5N8giIHnNOCX/NHB5lr1Ac/Z6wLMd5jma2K2h3so40l3SXm6w
         HqE1J6cbijCV+ipZHe+hdMcV4URcokr0xP65E2j6mHv8Com5VgfHYD3SK8/bEx08w4u+
         7KP83diFG2l/VmIF+WsNdBwraudcRDVkvkdOcFn/GjfftT57y/BB1THwvDkYn8fRKjDf
         nmL1U9NcDz2CMB+y+cEkVrXBvpwEVDSBbmmrnFqNHv1kYnC9LVwn8i4hdbKYsJlvNbuj
         AgZ+vDqs4VKH3TnPSzcd6HVRwsqH64QfBqXoqE+7L/vM9k3NarhBW7abqRqBqg+LXpzN
         6K6g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1770838838; x=1771443638; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtFHLX3t7mFwB3FyF/7aRQrPd6PJdO/LGE1y0kBPp6M=;
        b=e1Coib+MSW7Wx+qGX1gar8d4a3VfvA5pC0NPXxxpPxsgE3GP6jn+kLfaNjP26uV/WN
         KDZPsO+d3wF78c0eo7CRFvvbc+p+rrfgP9yBwzUb+Ma7Qb+EdbXCEt3gC3mTNylZe+mt
         NPoatlrBP6nlYZ8zSqx51RZK/aSzGqJ8jOV8Jj2SFEqEh3nWrN+WChtBGiMbC3iV76E8
         FR5ocI+0O7+WYLNb9KXvUu4MOjsGM2nL43ugjfGJ3zopOudxFYE/6TwLc5uHZJiWUcSW
         JvpGomt7EBtu+pNzZtSUqKEfZIGZkloTVm0JotZTS/t21YcrwulWLXab9Zp09V5PLfXF
         ZDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770838838; x=1771443638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mtFHLX3t7mFwB3FyF/7aRQrPd6PJdO/LGE1y0kBPp6M=;
        b=AxAI4fkp4YN7RJ1vQxfdNh9em1JrRvgJq8i8ifeGtztEedBTUhXIuoJxl1pE4jipJG
         za6N7gjFFCMH1EUyewFFc7GA3Z+3hdHbTqe4Y7WvJqjIpgXRy+Li2udZboev/zUKQe4n
         ZTA94mwGzwkiUVc/VtFZ+ZJp7WB2FAiJWzi9225LcG1ftAj3kWOsmOKK+bD/hhKaL7wp
         ZOY2bHJNzy+FlR3X4irrt9AovYKb6cCqjCofAWc+cFFiqAl6Hf0ebLpOGL3S+XzYIIPf
         JcY1pXNe3F1/J6mwA/uIDx2vNDZQTpsCqEq96l8qJ9ztYgEl9wX76UxXLTud8K1Gt7P/
         SE/w==
X-Forwarded-Encrypted: i=1; AJvYcCWxGl7hTmxgSMhmFFKtm6vRKFY0XaGRohu88oSNnPkdcvLmtov7xOVZnPxn0mrFp1LCDUeAgA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzehcwbwUKG1jHteO/BjjtBrRM/CJZLwhl3QfXdkzZ3ens1yyIT
	JAQw/ozdtti2+1fwzMsSW4wqwKPhlMY+41eT8DJ/HtxAl9AhwrPTRQDcyuVz0oVKEKY1yTZfYys
	9gU1t/453fN53NEuik3u0GNtrP/yejWMy2Hsa20KUKQ==
X-Gm-Gg: AZuq6aIQZUQRUvVpt2L019MSKrPr8Gh+Gi/7i6SGQJhYNoI7EGQCNev9HDSB+jHtzTx
	k1ZztLvstmQRiOY+7FfVJObccT11Y08EBYJWFEkHXDBZ1ZAYMEo1XPBGzPh0potceiwLNXyS9nJ
	ZjcFvSUIcwhfI9n64fCHOz8zqtUhHt5+GG553RlEcD2GN19Qf4eRVlf6qMUxeSmwJD7jL7ikXyT
	qNp/43c06WDfG2LRQ6mtvDmoDiRuroISILT+xHU1MO6DlKVa6vZ9yL2naX5k+p9PX91ahcaUo4r
	lWUofDDlgvKFyhnUT/0/4LYgN/Egcpw1Mprykw==
X-Received: by 2002:a17:907:3f9b:b0:b87:7485:b4a8 with SMTP id
 a640c23a62f3a-b8f8ea91a6bmr15769166b.0.1770838837841; Wed, 11 Feb 2026
 11:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20260211173954.2091119-1-mclapinski@google.com>
In-Reply-To: <20260211173954.2091119-1-mclapinski@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 11 Feb 2026 14:40:01 -0500
X-Gm-Features: AZwV_Qhj_LXM_nkisF1dHW372t93JNjWhBHaT4GRxWYkxOjMAeZJR4yIQonUYk4
Message-ID: <CA+CK2bBfJDD5SPJqwCaGbaGZe9FncONMsck0QkOb8WwmDSh_Yg@mail.gmail.com>
Subject: Re: [PATCH v3] kho: add support for deferred struct page init
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_114041_412926_82260656 
X-CRM114-Status: GOOD (  13.81  )
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

On Wed, Feb 11, 2026 at 12:40=E2=80=AFPM Michal Clapinski <mclapinski@googl=
e.com> wrote:
>
> From: Evangelos Petrongonas <epetron@amazon.de>
>
> When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> initialization is deferred to parallel kthreads that run later
> in the boot process.
>
> During KHO restoration, deserialize_bitmap() writes metadata for
> each preserved memory region. However, if the struct page has not been
> initialized, this write targets uninitialized memory, potentially
> leading to errors like:
> BUG: unable to handle page fault for address: ...
>
> Fix this by introducing kho_get_preserved_page(),  which ensures
> all struct pages in a preserved region are initialized by calling
> init_deferred_page() which is a no-op when deferred init is disabled
> or when the struct page is already initialized.
>

Co-developed-by: Michal Clapinski <mclapinski@google.com>

> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> v3:
> - changed commit msg
> - don't invoke early_pfn_to_nid if CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dn

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha

