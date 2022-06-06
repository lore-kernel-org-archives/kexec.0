Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AEDC433EF
	for <kexec@archiver.kernel.org>; Mon,  6 Jun 2022 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BxtEdgqp1LV2Rou9XG5E/+8Fy6QFhgjxNlLNh0h18Hc=; b=GgNCFdeBJWw0AX
	pi+qEqS5rfft0X6vZQlbwFL+Ir99r9aYl3k844pVR1QeiMCJZxs+StIyIdENWiwY/IbMEVJccth80
	Q3JKebHLvrfjDOgPK2BwCZcH/IE/saOe4pDHlfdYPRb0h5++CpEEYILRM9MQmB9cU9nF8S+ciyQ4/
	koBe3sUsM03Fmrfm4BqgjfI+SPRyb1qDnEuWx3ZJf7YVlCe1Tju4vrTPaCE6l48jRh0kOMqCXNUhe
	ePEhOw3HHRAoszx4dIsCK4kWojedGYFfwu8pUZrh3CQnIWhhfkxezkCZaeTa2jTEPJoU5gMHf95U3
	xkZX8BKeoawKkAJk9ZVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyGRC-002Cot-OC; Mon, 06 Jun 2022 17:22:46 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyGRA-002Cnh-Bl
	for kexec@lists.infradead.org; Mon, 06 Jun 2022 17:22:45 +0000
Received: from [10.106.160.111] (unknown [167.220.57.111])
	by linux.microsoft.com (Postfix) with ESMTPSA id 956A320BE618;
	Mon,  6 Jun 2022 10:22:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 956A320BE618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1654536159;
	bh=R1pfROGO59ApnhUFBsXVmjnbtfL6z8PoIQXncmwF47A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EhG1L83Wa8gFk7/ip+gojteOfXpqOvVgpF9dex+EbPD9elZyXkwTLWZvIX1ZUGius
	 0Qme6HZtynxCYnFtuXjUoNYYtxiJ0pcTz1CMmNwc0MFW4+zmekT/Tqkd5+PAN4F1SN
	 y9JvF6cOmprg/RLZx9IgRJ7OZWlfMFA7DFLLd2bw=
Message-ID: <7452c305-dad4-2836-1d21-1c051f15f11c@linux.microsoft.com>
Date: Mon, 6 Jun 2022 10:22:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: need help: patches to capture events between kexec load and
 execute
Content-Language: en-US
To: Jonathan McDowell <noodles@fb.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Alasdair G Kergon <agk@redhat.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Tyler Hicks <tyhicks@linux.microsoft.com>
References: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
 <Yp24dc/i8XU9A+5/@noodles-fedora.dhcp.thefacebook.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <Yp24dc/i8XU9A+5/@noodles-fedora.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_102244_479521_2C7CB4AE 
X-CRM114-Status: GOOD (  17.00  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Jonathan,
Thank you for taking a look at my patches.

On 6/6/22 01:19, Jonathan McDowell wrote:
> The main piece that seems to be missing is updating the size of the IMA
> buffer in the mechanism used to pass its details to the new kernel (so
> device tree in current mainline [setup_ima_buffer], the setup_data piece
> in my x86_64 patches). Without that you'll only load the original set of
> measurements even if the extra data is in the buffer.

Ok. Thanks for the pointer.
I will take a look at your patches and get back to you with updates.
> 
> I think there's also a potential problem in that you assume an extra
> page is sufficient for any additional measurements which may or may not
> be the case - I don't see any check in ima_update_kexec_buffer that the
> buffer is big enough for the new IMA data.
> 
Agreed.  I wanted to solve that problem next.
First I wanted to verify at least a few events are getting copied after
the kexec soft reboot.
But thanks for pointing this out.
> J.

Again, appreciate your pointers.

Thanks,
Tushar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
