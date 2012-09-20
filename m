Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TEn1D-0008UI-6N
 for kexec@lists.infradead.org; Thu, 20 Sep 2012 20:06:40 +0000
Date: Thu, 20 Sep 2012 16:06:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: makedumpfile 1.5.0 takes much more time to dump
Message-ID: <20120920200633.GL4681@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, chaowang@redhat.com

Hi Atsushi san,

We tried makedumpfile 1.5.0 on a 1TB machine and it seems to regress
badly. We reserved 192MB of memory and following are test results.

#1. makedumpfile-1.4.2 -E --message-level 1 -d 31
real     3m47.520s
user     0m56.543s
sys	 2m41.631s

#2. makedumpfile-1.5.0 -E --message-level 1 -d 31
real     52m25.262s
user     32m51.310s
sys	 18m53.265s

#3. makedumpfile-1.4.2 -c --message-level 1 -d 31
real     8m49.107s
user     4m34.180s
sys	 4m8.691s

#4. makedumpfile-1.5.0 -c --message-level 1 -d 31
real     46m48.985s
user     29m35.203s
sys	 16m43.149s

Thanks
Vivek






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
