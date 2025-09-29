Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F5ACAC5B9
	for <kexec@archiver.kernel.org>; Mon, 29 Sep 2025 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kGAfjnVIqOe7TGU9wLDMa51PSPKFwqTYSqJ+3odfiyc=; b=1Mx8bCHPbzlpi0gK+lBPBBVHsf
	BlS2hInYb3JxnX0m8K3TgaMpXarltkaPejXnq1RykgdrxVg3MQm6c/fpBqAJd9FHxmyAO/Lt5Kzy0
	MB6T031Qcp51112WLSybAjAOVu7N3MJwmlzQVRmPrVHMB4ypopF7pUTamkGqEIWG7uiRlloG3q3DD
	umUkJCTn2cX0pGEnzk2l0P8Wpv859dRjtsJrmGt7ORQQcqAjc/NDLh10tWFpuoCZMZYa8wZKH2LYF
	IfUzLg/xFOnqyIWXz2blp5MqtUtFhzmrGFzbNzNlOrEuxl8tLYwIF6mu1yqOFSImlNN3GopK7pKY3
	KQbQFQyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3JHs-00000003KFn-3ISa;
	Mon, 29 Sep 2025 19:11:52 +0000
Received: from mailout.easymail.ca ([64.68.200.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3JHq-00000003KDo-1f7j
	for kexec@lists.infradead.org;
	Mon, 29 Sep 2025 19:11:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by mailout.easymail.ca (Postfix) with ESMTP id 914CBE2EEA;
	Mon, 29 Sep 2025 19:11:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo08-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
	by localhost (emo08-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jnKYw9fIfU6T; Mon, 29 Sep 2025 19:11:46 +0000 (UTC)
Received: from rhapsody.. (unknown [38.175.187.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout.easymail.ca (Postfix) with ESMTPSA id 0BAA3E2EE7;
	Mon, 29 Sep 2025 19:11:45 +0000 (UTC)
From: Khalid Aziz <khalid@gonehiking.org>
To: kexec@lists.infradead.org
Cc: Khalid Aziz <khalid@gonehiking.org>,
	horms@kernel.org
Subject: [PATCH kexec-tools] COPYING: Update with current text for GPL v2
Date: Mon, 29 Sep 2025 13:11:31 -0600
Message-ID: <20250929191132.2511888-1-khalid@gonehiking.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_121150_491361_AF5FDF57 
X-CRM114-Status: GOOD (  13.78  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Text for GPL v2 has been updated to remove old mailing address. This
updates the license text in COPYING file with the current license text
from https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt

Signed-off-by: Khalid Aziz <khalid@gonehiking.org>
---
 COPYING | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/COPYING b/COPYING
index d159169..9efa6fb 100644
--- a/COPYING
+++ b/COPYING
@@ -2,7 +2,7 @@
                        Version 2, June 1991
 
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -304,8 +304,7 @@ the "copyright" line and a pointer to where the full notice is found.
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License along
-    with this program; if not, write to the Free Software Foundation, Inc.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+    with this program; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
@@ -329,8 +328,8 @@ necessary.  Here is a sample; alter the names:
   Yoyodyne, Inc., hereby disclaims all copyright interest in the program
   `Gnomovision' (which makes passes at compilers) written by James Hacker.
 
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
+  <signature of Moe Ghoul>, 1 April 1989
+  Moe Ghoul, President of Vice
 
 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
-- 
2.48.1


