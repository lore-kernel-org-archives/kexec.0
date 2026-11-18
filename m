Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30313606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oJjY396r;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPsvaCBr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=8+cDiLZK9L/YS300C4QyCSJrnELmUNWdwpQ2IHXg80Y=; b=oJjY396r7c4Svi2ibZaTiXd9gN
	4H+b/A3DlnYPq1yid5Du2R5tutme8d5rwdqdgl68N5DLSGJfwM/m6jOrETSYfGlfd0V4FzHJdSKoI
	5yjbiV5rtdct9IZwifnt9BRXv4xhovqLBkMW92Y+XcNDNuu62rfHhbjBFgGoL4yj9y5oeinMQ9CxK
	3qppDqPB3AW45QuY5QBVC3N9Ll4jAP/PdWW+OedO1gTH/DrLbG7ubUQDBbwaqZKC1hDdcAbO6C7+p
	I/3nnNN48GpCtqPZZBQEQB/vKYtNbhu7v7PUUUzta5BuRchPJ7j5etgScxxJex5Eoqc8HnvhdFm6a
	xgG0b9FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTSt-00000007LZs-37Cx;
	Wed, 18 Nov 2026 00:23:55 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTSn-00000007LZJ-3sLU
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 00:23:52 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so245733b3a.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 16:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794961429; x=1795566229; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8+cDiLZK9L/YS300C4QyCSJrnELmUNWdwpQ2IHXg80Y=;
        b=RPsvaCBrmJCLGnuPt4divps7zw7Ma8m/aoy5+WlQ96VysvYxRDmPs+zLQddnDuEE/W
         baEWaiF9yA1XIE9DWHClh/VGYmOgNwN9RCaNdCSiBit+ue3epzrBg0LUpNIhCVYeLOXo
         /+gV3Rrsbbsq0KQCJ5ScOrRjcfdL6mznnAiIyei84HHJ0Wek2vUePV3NafRiumPPcARD
         QvGrG8RnirBf6x1T4Z1BI83Mns3CPEV6/bSRtzk5k2tt+yrxe3TafGw7u0UeNL8N7D1/
         DQombS3Y6L763/g9sQamdxwzPcm/vDLTtauYGHyYlKAK0p0nfCaM1BJHnhEWF9P14mjF
         uRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794961429; x=1795566229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+cDiLZK9L/YS300C4QyCSJrnELmUNWdwpQ2IHXg80Y=;
        b=GkEL7tfVoFHWMTMnZLIpguROt8onb4kHEJ/HfZ1IrYcmC3T/CIUlBwSmEGXnsrPwd8
         1w5Z5bz4jwbHD5SCMt6b4km875makloJSbfzgC9/Mf49vY7tKdK7rs9yfr6vKCBF0nPS
         3hp28tSy4d1T/30SQj/uORWsrVAj0SRnezf8Rfpa2w6EhC0jlP7/24MA5ZMlRwJvWgBa
         rtPrn0MVSvFYydAQax0jLcvZBuS7LY7I62POTA8y4VncRd0WnGeVFxLzc9goNHKy5qaV
         Qw9fxWKWutsoVafmwZ9OQEgr34Nfs10lC7HpiN6CZ5umE0wVVpYwz9xHyET70uZ2g5OJ
         JSkQ==
X-Gm-Message-State: APuU4Z8fdtlQ27OAhIa5udy99QZzBXa/kKQBzQ8ZsOqalTnYBCfibOm4
	2Q1IKMuHx+RwItXe6bFk2JX6uwhs3995PiycVqIspaztQtZHdbf/SVKqzgs4AqKu+FE=
X-Gm-Gg: AYBFou33CxtJGB7HIBmtTJM8hEv4QZ+TyECj5YRGE/gptbPL2Ufu2TZX8yjg85xEszg
	svMZvBxNluqYjDFX+xLP+bfJOWH5KgIQtM0kw8zWOIBrSPqqKClJqtxh+N5Z+fwEvo2yHs0IUwt
	ugcuGNRGD/lIv0b8goI9Hk9DacBXnxS091dpWNsTcV8zNdj+ctgb76OIYnNlMQGlyzO4uAvwxzL
	uK8QvZKGwdr2ds0oalh1RjarASsfHLB9Owd5E77lxzdjj/7xpQuKaNHgzqmMncpqO8tfj0MYe+L
	ROljlKGhpqgAMYEz9CuM3D5hm3XgsVRlb5hafkMXATax9RGG4FbpbG2J3LkYz1Eb3aACS4R9+Vm
	prmGFSgWb7zzrSXK9a+1474irPLGw/hH36xKyjscjMuoy2BTiDgAald5W+wqcyD0ojjbGRdqj9i
	9XExzaTyPVLzd4/Y2QWmP1d4ksWbxcKQp2wKIzd4WmAx6AsloqbDRJcNFAXRtqYqAulhpLWNl//
	Gri9+pfaSipOi02s37s5jLfcINNRZklYWaGoQRL8RCAmNKyxBcrApnsSbNGMJ+4Fb7iFV+9TVTJ
	JJkcXPdvb77BmARShXpo+3CkMDsuP5OAkUaGkCJuYb/nWUb+B20qe3BeeqM=
X-Received: by 2002:a05:6a00:4285:b0:881:9f52:ca00 with SMTP id d2e1a72fcca58-8c5d539b795mr670320b3a.42.1794961428348;
        Tue, 17 Nov 2026 16:23:48 -0800 (PST)
Received: from localhost (42-2-113-197.static.netvigator.com. [42.2.113.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5c7f99fb5sm250748b3a.4.2026.11.17.16.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:23:47 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: YAMAZAKI Masamitsu <m-yamazaki2@nec.com>
Subject: [PATCH makedumpfile] Fix incorrect-fsf-address error in license file
Date: Wed, 18 Nov 2026 08:23:44 +0800
Message-ID: <20261118002344.11968-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_162349_992540_6DEDE421 
X-CRM114-Status: GOOD (  17.27  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rpmlint reports the following error,
    # rpmlint -v makedumpfile-1.8.0-1.fc46.x86_64.rpm

    makedumpfile.x86_64: E: incorrect-fsf-address /usr/share/licenses/makedumpfile/COPYING
    The Free Software Foundation address in this file seems to be outdated or
    misspelled. Ask upstream to update the address, or if this is a license file,
    possibly the entire file with a new copy available from the FSF.

Update COPYING to latest
https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
to fix this error.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 COPYING | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/COPYING b/COPYING
index d511905..9efa6fb 100644
--- a/COPYING
+++ b/COPYING
@@ -1,12 +1,12 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
+                    GNU GENERAL PUBLIC LICENSE
+                       Version 2, June 1991
 
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-			    Preamble
+                            Preamble
 
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
@@ -56,7 +56,7 @@ patent must be licensed for everyone's free use or not licensed at all.
   The precise terms and conditions for copying, distribution and
 modification follow.
 
-		    GNU GENERAL PUBLIC LICENSE
+                    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
   0. This License applies to any program or other work which contains
@@ -255,7 +255,7 @@ make exceptions for this.  Our decision will be guided by the two goals
 of preserving the free status of all derivatives of our free software and
 of promoting the sharing and reuse of software generally.
 
-			    NO WARRANTY
+                            NO WARRANTY
 
   11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
 FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
@@ -277,9 +277,9 @@ YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
 PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.
 
-		     END OF TERMS AND CONDITIONS
+                     END OF TERMS AND CONDITIONS
 
-	    How to Apply These Terms to Your New Programs
+            How to Apply These Terms to Your New Programs
 
   If you develop a new program, and you want it to be of the greatest
 possible use to the public, the best way to achieve this is to make it
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
2.56.1


