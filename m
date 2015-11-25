Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22d.google.com ([2607:f8b0:400e:c03::22d])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1Pe9-0003fE-Sd
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 02:17:27 +0000
Received: by pacdm15 with SMTP id dm15so40739491pac.3
 for <kexec@lists.infradead.org>; Tue, 24 Nov 2015 18:17:04 -0800 (PST)
Received: from monster-15.cumulusnetworks.com. ([216.129.126.126])
 by smtp.googlemail.com with ESMTPSA id xr8sm17475815pab.26.2015.11.24.18.17.03
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Nov 2015 18:17:03 -0800 (PST)
From: Curt Brune <curt@cumulusnetworks.com>
Subject: [PATCH 0/1] Improve device tree directory sorting
Date: Tue, 24 Nov 2015 18:17:09 -0800
Message-Id: <1448417830-48786-1-git-send-email-curt@cumulusnetworks.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch improves the device tree directory sorting.

Previously the sorting algorithm would result in the following ordering for a
Freescale P2020 SoC device (Rooted under: /proc/device-tree/soc@ffe00000)

  #address-cells
  #size-cells
  .
  ..
  bus-frequency
  compatible
  device_type
  i2c@3000
  i2c@3100
  mdio@24520
  msi@41600
  mdio@26520
  serial@4600
  ethernet@26000
  global-utilities@e0000
  memory-controller@2000
  l2-cache-controller@20000
  name
  pic@40000
  ranges
  sdhci@2e000
  serial@4500

Ideally 'serial@4500' would come before 'serial@4600'.  This would
cause the new kexec-ed kernel to have the serial consoles detected in
the wrong order, i.e. ttyS0 and ttyS1 are swapped.  

Using the attached patch the same directory is ordered as:

  #address-cells
  #size-cells
  .
  ..
  bus-frequency
  compatible
  device_type
  ethernet@26000
  global-utilities@e0000
  i2c@3000
  i2c@3100
  l2-cache-controller@20000
  mdio@24520
  mdio@26520
  memory-controller@2000
  msi@41600
  name
  pic@40000
  ranges
  sdhci@2e000
  serial@4500
  serial@4600

Curt Brune (1):
  Improve device tree directory sorting

 kexec/arch/ppc/fs2dt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
