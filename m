Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zc87R-000600-LV
 for kexec@lists.infradead.org; Wed, 16 Sep 2015 08:31:11 +0000
Received: by wicfx3 with SMTP id fx3so59376476wic.0
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2015 01:30:42 -0700 (PDT)
From: Nikolay Borisov <kernel@kyup.com>
Subject: Reducing the size of the dump file/speeding up collection
Message-ID: <55F928B1.4080703@kyup.com>
Date: Wed, 16 Sep 2015 11:30:41 +0300
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: SiteGround Operations <operations@siteground.com>

Hello,

I've been using makedumpfile as the crash collector with the -d31
parameter. The machine this is being run on usually have 128-256GB of
ram and the resulting crash dumps are in the range of 14-20gb which is
very bug for the type of analysis I'm usually performing on crashed
machine. I was wondering whether there is a way  to further reduce the
size and the time to take the dump (now it takes around 25 minutes to
collect such a dump). I've seen reports where people with TBs of ram
take that long, meaning for a machine with 256gb it should be even
faster. I've been running this configuration on kernels 3.12.28 and 4.1
where mmap for the vmcore file is supported.

Please advise

Regards,
Nikolay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
