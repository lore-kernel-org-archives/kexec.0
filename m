Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96956CCA470
	for <kexec@archiver.kernel.org>; Wed,  1 Oct 2025 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pz5DiaUIUpH5xDPSpcYQUbcl/M7XnZ0YA9dOeOfZYII=; b=hSKJeLLd33A/WkeQt1vsJtOSfB
	+ISjhLOBr2roPYSyGL1ZH1uaX5bIZygIl0py52uA7lattIZJCMXNp9WneIVydcrAIBDXiuo3+oUNX
	LXEW7oEsTnXErrv0DRvoPhDVVFvN4mZdvpWPLXkQBgYpIscq+rIgNF0Owml679+VwqxkAKVJIejxK
	swLFAkywyOXgMQq+WCnd5xtqX6KwVwa7pb9LNGVD5bNmJj0hG8sZhTWfgEUMSNVmYT54JRymnutb1
	8UHA0Sx5nUXcBNySkTWsOaZngSYq5wPLO31OTtajQzVgepHSGldbb011jSX0dXkud+Ygdk07cj+1w
	z7Stffeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3wAE-00000007vml-1aem;
	Wed, 01 Oct 2025 12:42:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3wAB-00000007vmB-3Qsy
	for kexec@lists.infradead.org;
	Wed, 01 Oct 2025 12:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759322549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pz5DiaUIUpH5xDPSpcYQUbcl/M7XnZ0YA9dOeOfZYII=;
	b=aEdc9YYdLF3aTDDtz+5LlzyWJKoCcOhatY2aJ7p7CERFEOHHXvjHMObmOCf+fI0TDJu8dF
	6mO/00ywn8+14SnE5aPvuT3jhSJcDEg1Seh/M/Nbnf9pZeLtskV8BPomnToULOEC1q+oZL
	kr3Kfc1RS37v0VoSSYFlVrZfdj5MSGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-G_xKfARVNr2Jo5L4fw5brA-1; Wed,
 01 Oct 2025 08:42:26 -0400
X-MC-Unique: G_xKfARVNr2Jo5L4fw5brA-1
X-Mimecast-MFC-AGG-ID: G_xKfARVNr2Jo5L4fw5brA_1759322545
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 650301800576;
	Wed,  1 Oct 2025 12:42:25 +0000 (UTC)
Received: from localhost (unknown [10.72.112.73])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6423A1800576;
	Wed,  1 Oct 2025 12:42:22 +0000 (UTC)
Date: Wed, 1 Oct 2025 20:42:17 +0800
From: Baoquan He <bhe@redhat.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, coxu@redhat.com
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] dm-crypt: remove ineffective comparison
Message-ID: <aN0hqT/iTAWodgXJ@MiWiFi-R3L-srv>
References: <20251001120254.24980-1-suchitkarunakaran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001120254.24980-1-suchitkarunakaran@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_054231_929309_509EDB79 
X-CRM114-Status: GOOD (  17.15  )
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

CC Coiby,

On 10/01/25 at 05:32pm, Suchit Karunakaran wrote:
> In restore_dm_crypt_keys_to_thread_keyring(), key_count is a global
> variable declared as unsigned int. The comparison key_count < 0
> is therefore always false and has no effect.
> Remove the dead comparison to make the code clearer and
> silence static analysis warnings.
> 
> Found by Coverity: CID#1649028
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  kernel/crash_dump_dm_crypt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 401423ba477d..39cfc13ff350 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -115,7 +115,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>  
>  	addr = dm_crypt_keys_addr;
>  	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
> -	if (key_count < 0 || key_count > KEY_NUM_MAX) {
> +	if (key_count > KEY_NUM_MAX) {

Sounds reasonable to me,

Acked-by: Baoquan He <bhe@redhat.com>

>  		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
>  		return -1;
>  	}
> -- 
> 2.51.0
> 


