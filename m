Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7709BC4332F
	for <kexec@archiver.kernel.org>; Tue, 13 Dec 2022 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N80DRloBLjwAp2FX/Awzzs3y4aLJ2UiAL7rZhIi5X+c=; b=TVAy5qNjeCgJua
	Co9VDeMwGeZmMXkrGNczGxVXSeYFIsugHkzGlXIrv94UKspdGCHQTjW0Pc5rIKqOa+vRt4+1fUDx0
	81YRmpENLBhdBR0/hryBRVAW62V3WahwYuPbS6ZHP+XcaClh+CKrA168P0OUDM3/6ZSpo7e1r+aYt
	mnJOhAAaKMEv0kjLTANbNmqZ8XyCOgPksKgHi4J/rcAlF2fKJed+RPB6pHDcgjxKFIlXif0Jz/AB1
	zT5GjDRmDBIllCA9Nqu/VQngyj33NaGCH33LK3BP/+sYtZIJabhlkDeo3S6qW4f7oBUKYkuGfuHn6
	oWZU8xklcO3Gpd/7kyuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5F3Z-008F80-20; Tue, 13 Dec 2022 23:51:29 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5F3S-008F2h-SX
	for kexec@lists.infradead.org; Tue, 13 Dec 2022 23:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SIYlH3jyQM0ZotVnKMTJahO1+18k0UeyRqHK151oXCw=; b=h6OxnK0Hia6cBHVgqE0aBM67nc
	kVuK4sBzSdEpUrHmIx3tLY7JZ8GCvnAGazLHo+9GSTRCdIy3BcdJt5OthM8r9pvp0OIrViBEpQAYA
	/Rqc2OrnyWgqn+xEKji6L9mXG4tMQSHuVrgl63wdZGi/OAVZI4a3Pefxk47MCg40uvPY2XJZ3jzf5
	gkYyvYJCdfQBtafsbTo2/Kn5Ju2vZ/ul/fKMPVnDODQM/RfUXRzxJWMwvQXcpVeftE6jsacu/we3v
	DDMJcr/+fNf/QX+pyQyL+cBuxeGtCJ51h8OPTwK5E20v0e2gL17eSkCn+42PuW+xN53YCxR3ZgIIS
	fhO4WYBg==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1p5F3H-002r2P-FD; Wed, 14 Dec 2022 00:51:11 +0100
Message-ID: <f29935e3-e3b6-2d4e-7fc1-267e1ef0925b@igalia.com>
Date: Tue, 13 Dec 2022 20:51:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-7-gpiccoli@igalia.com>
 <20221020172908.25c6e3a5@gandalf.local.home>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221020172908.25c6e3a5@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_155123_013806_72BCE544 
X-CRM114-Status: GOOD (  10.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 20/10/2022 18:29, Steven Rostedt wrote:
> On Fri, 19 Aug 2022 19:17:26 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>> Currently the tracing dump_on_oops feature is implemented through
>> separate notifiers, one for die/oops and the other for panic;
>> given they have the same functionality, let's unify them.
>>
>> Also improve the function comment and change the priority of the
>> notifier to make it execute earlier, avoiding showing useless trace
>> data (like the callback names for the other notifiers); finally,
>> we also removed an unnecessary header inclusion.
>>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Sorry for the late reply.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Hi Steve, since you were so kind in the other patch...decided to ping in
this one as well heheh

So, do you think it's possible to pick it for 6.2? No dependency here,
it's a standalone patch.

Thanks again and sorry for the annoyance!
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
