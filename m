Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nuclearcat.com ([144.76.183.226])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cc6Lb-0008OI-Sq
 for kexec@lists.infradead.org; Fri, 10 Feb 2017 08:14:30 +0000
MIME-Version: 1.0
Date: Fri, 10 Feb 2017 10:14:02 +0200
From: Denys Fedoryshchenko <nuclearcat@nuclearcat.com>
Subject: kexec on panic
Message-ID: <52a88de81ea3c62bb2be9e222eb85805@nuclearcat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org

Hello,

After years of using kexec and recent unpleasant experience with modern 
(supposed to be blazing fast to boot) hardware that need 5-10 minutes 
just to pass POST tests,
one question came up to me:
Is it possible anyhow to execute regular (not special "panic" one to 
capture crash data) kexec on panic to reduce reboot time?

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
