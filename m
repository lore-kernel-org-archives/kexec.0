Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d5S69-0003Pu-76
 for kexec@lists.infradead.org; Tue, 02 May 2017 07:19:50 +0000
Received: by mail-ua0-x22e.google.com with SMTP id g49so17270116uaa.1
 for <kexec@lists.infradead.org>; Tue, 02 May 2017 00:19:28 -0700 (PDT)
MIME-Version: 1.0
From: Dumslicer Halo <dumslicer@gmail.com>
Date: Tue, 2 May 2017 12:49:27 +0530
Message-ID: <CAAhEX+KVeHHNucs6tZwvwFD9QXNptj1-1fih=seu8uRdB6S13w@mail.gmail.com>
Subject: Help regarding renaming of vmcore-incomplete to vmcore
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

Hi I am a university student, and have made some changes to
makedumpfile to produce a gzipped output of core dump. The issue I'm
facing is that the output i get from makedumpfile (after it completes
successfully) is vmcore-incomplete.gzip.

But this file is not being renamed to vmcore.gzip (even thought the
dump the complete as I verified it by loading into CRASH utility). Can
someone please point out to me the changes I should make to solve this
bug (or  can point to the code where this renaming is done).

Thanks and Regards,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
