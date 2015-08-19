Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZRwkq-0004ey-Jk
 for kexec@lists.infradead.org; Wed, 19 Aug 2015 06:21:45 +0000
Received: by wicne3 with SMTP id ne3so117390306wic.1
 for <kexec@lists.infradead.org>; Tue, 18 Aug 2015 23:21:12 -0700 (PDT)
Received: from localhost.localdomain ([82.118.240.130])
 by smtp.gmail.com with ESMTPSA id i6sm29522891wje.33.2015.08.18.23.21.11
 for <kexec@lists.infradead.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Aug 2015 23:21:11 -0700 (PDT)
From: Nikolay Borisov <kernel@kyup.com>
Subject: Dmesg not being dumped
Message-ID: <55D42056.5070709@kyup.com>
Date: Wed, 19 Aug 2015 09:21:10 +0300
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

Hello,

I've recently noticed that when creating crashdumps the dmesg is not
being saved. The error reported is this: "Missing the struct log size
export". I've tested with both kernel 4.1.1 and 3.12.28. My version of
kexec tools is : kexec-tools 2.0.9 released 04 June 2015. The kernel has
been compiled with debugging info so the respective symbol should be
exported but apparently it is not. Any ideas how to debug that?

[Please CC me as I'm not subscribed to the mailing list.]

Regards,
Nikolay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
