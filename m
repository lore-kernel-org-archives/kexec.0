Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gw1.esolutions.de ([178.239.73.50])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRas-0002up-U8
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 16:29:51 +0000
Received: from DEGAMES01.eso.local (degames01.eso.local [10.2.0.245])
 by mail-gw1.esolutions.de (Postfix) with ESMTPS
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 17:25:07 +0100 (CET)
From: Tschigirinski Jewgeni <Jewgeni.Tschigirinski@esolutions.de>
Subject: kexec: relocate_kernel fails
Date: Tue, 15 Jan 2019 16:25:05 +0000
Message-ID: <A019E0A5E55E844784593A3634C1DB07465D5FAC@DEGAMES02.eso.local>
Content-Language: en-US
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

I am not able to get kexec to work. For x86_64 relocate_kernel fails to store information for jumping back.

Kexec stops in movq %r9, CP_PA_TABLE_PAGE(%r11).

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
