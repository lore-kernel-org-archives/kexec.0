Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYMmI-00006A-GR
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 21:44:58 +0000
Date: Thu, 10 Apr 2014 17:44:33 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: makedumpfile memmory usage seems high with option -E
Message-ID: <20140410214433.GF18808@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Arthur Zou <zzou@redhat.com>

Hi Atsushi/Hatayama,

We noticed in our testing that makedumpfile gets OOM killed if we happen
to use -E option. Saving to compressed kdump format works just fine.

Also we noticed that with -E if we disable cyclic mode then it works just
fine.

So looks like something is going on with -E and cyclic mode enabled. I am
not sure what it is.

Do you suspect something?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
