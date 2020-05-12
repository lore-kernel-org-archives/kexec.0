Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYZRB-0002VL-Ul
 for kexec@lists.infradead.org; Tue, 12 May 2020 18:15:31 +0000
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1jYZR8-0006Kt-9w
 for kexec@lists.infradead.org; Tue, 12 May 2020 18:15:26 +0000
Received: by mail-ed1-f69.google.com with SMTP id m6so5590587eda.16
 for <kexec@lists.infradead.org>; Tue, 12 May 2020 11:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200512172546.GL31850@zorba>
In-Reply-To: <20200512172546.GL31850@zorba>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Tue, 12 May 2020 15:14:49 -0300
Message-ID: <CAHD1Q_wJGA+b9hgLhUUt2fBK8aEOchis9EDW4W8JVQ1EreFwqA@mail.gmail.com>
Subject: Re: [REQUEST] makedumpfile: stream compress flat ELF format with libz
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
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>

It's a quite interesting feature Daniel, thanks for the effort!
I'm curious about memory usage - did you somehow measure the
consumption with your patches vs. the regular kdump compression?

Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
