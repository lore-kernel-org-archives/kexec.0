Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AEAC67861
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 06:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=riJZkq/aDOXeI4yQVlYe3YfM8HwduxnhzyRRHVo87sk=; b=Mp7SApUTpc24et
	umGX1X+8Ao7CEg1orLvZHUGIh5qXS0AEy+WwPOsLVMen7Emk+kuNQ68Jq68X7CH85OQYfGRZcfTuJ
	S7luLOs6IjSDMcQ4ZMPwp/0wPiHLojjaOdIeHYGC4A36PgD8PgmuAb1/VExUwzWNSD8yCw3cWhWdm
	ZavHbfngkfsvC7dM8dkfE4nmyvvKIIDt+eSoekXk6AGMknjkjS/dRJ8zYlurL0FV2cgPf6JBye7tO
	1s0x363HyBtYYuWTCh/u3QKLn4kTBuNLamo954QOLpWPBpBtpEFeYoXAt7bZlM6KLBJTZ3QzqztN3
	oZ9BMwIJh5EfMnpd5wmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtifq-0000000EXkw-0ja5;
	Mon, 08 Apr 2024 06:40:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtifm-0000000EXji-1h1u
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 06:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712558401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SAHL1tM7DZeCCLxhyKK3udN66wutDrGvk+AiPTemaL8=;
	b=VlbevggxcKU0R2auWJk1cwnOEdPrO1Beg/aBQPQys5URFTUbVUOoZfs48MhVt/6pYOZ7nV
	Eq4FnaUp5DIiQU9M350avDlqqkhCNoYYE3I9ngBCknLqVeSVA74U6FfQ8/BOfYwLx/lvcW
	7YOZkuWYdWaYx0zS7EXhp+lEE+HBUO8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-r2PoOByLP6WbmYB3OFZOzQ-1; Mon, 08 Apr 2024 02:38:01 -0400
X-MC-Unique: r2PoOByLP6WbmYB3OFZOzQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e2a1619cfcso31725815ad.0
        for <kexec@lists.infradead.org>; Sun, 07 Apr 2024 23:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558279; x=1713163079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qK0nDSFXN4nftK4Mjf0+lkQfXbrq2OtrIYGyvnhbTyM=;
        b=QZp3OUhS43aNSjd/mRAzpHSQT2DYHbCYCoDKIb+eeGt2m8xzJosyQmcBqfqVaLXeiN
         V4PWogGHFeh/gSUX8NOVP6+oYgsd04xPk0Cyd1QDiA9knzlDfzGbC9C1xLbPewzyHuFG
         KY/U6rwxUkmYKEY1bW5eqzvVHGQc09u629i3IFU9Pee0oIGiaYhat43hgls3r4UQAm8s
         c6NH0x4FTtsiODjK23ieeJ+1aYfR/vRcQH5CF1hIFMgSTaAu73y1eKU2ABS+aafpiFgs
         PN3zXQ9Lt/dVxmsNv+ESwdTK7XhMlRjUL/KaCxAW2+dvCWsdIvOVjG4/T7ORUJsaHdVk
         sA4g==
X-Gm-Message-State: AOJu0YwgH3CnTXTmTLMr8ygmXwGaVIYWTyFyAnRu7DZQV1SMEcNOn6nV
	3pKAp4zxxqWjfSZZ9MPuiMBX4zkb8KEWfBnKjfxkXWfDVDgabVFU0LA6pjjoXONqOCUgdc+cqPj
	WisDJqMGztmt2ij+ZlJppczzpwsrA1MKkjLNeR13nBMwniKL3nUVWjxPMhDLLlXezwC02bT/3DH
	FMfBb/NomabwT9H8TmCNHjrqx+x2I5dNq5JYopye5FvA==
X-Received: by 2002:a17:902:d4d0:b0:1e3:e6cb:a07f with SMTP id o16-20020a170902d4d000b001e3e6cba07fmr5909264plg.26.1712558279252;
        Sun, 07 Apr 2024 23:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER+i2hOhWRcbO1FuJ2OooyR8EPwlXtFEHUq+tvhyqLN3qLfe1VqsXBqJ3CyRdwbNy0N+q9VA==
X-Received: by 2002:a17:902:d4d0:b0:1e3:e6cb:a07f with SMTP id o16-20020a170902d4d000b001e3e6cba07fmr5909215plg.26.1712558278271;
        Sun, 07 Apr 2024 23:37:58 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b001e2086fddecsm6107136pli.139.2024.04.07.23.37.57
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 23:37:57 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Subject: [PATCH] Fix incorrect Free Software Foundation address in the license
Date: Mon,  8 Apr 2024 14:37:55 +0800
Message-ID: <20240408063755.942088-1-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_234006_682191_EBEDFEB3 
X-CRM114-Status: GOOD (  26.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

As detected by rpmlint,
    kexec-tools.x86_64: E: incorrect-fsf-address /usr/share/licenses/kexec-tools/COPYING
    The Free Software Foundation address in this file seems to be outdated or
    misspelled. Ask upstream to update the address, or if this is a license file,
    possibly the entire file with a new copy available from the FSF.

Replace current one with
https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
to fix this issue.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 COPYING | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/COPYING b/COPYING
index a52b16e..d159169 100644
--- a/COPYING
+++ b/COPYING
@@ -1,13 +1,12 @@
+                    GNU GENERAL PUBLIC LICENSE
+                       Version 2, June 1991
 
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
-
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-                       59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
+ 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-			    Preamble
+                            Preamble
 
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
@@ -16,7 +15,7 @@ software--to make sure the software is free for all its users.  This
 General Public License applies to most of the Free Software
 Foundation's software and to any other program whose authors commit to
 using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
+the GNU Lesser General Public License instead.)  You can apply it to
 your programs, too.
 
   When we speak of free software, we are referring to freedom, not
@@ -56,8 +55,8 @@ patent must be licensed for everyone's free use or not licensed at all.
 
   The precise terms and conditions for copying, distribution and
 modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
+
+                    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
   0. This License applies to any program or other work which contains
@@ -111,7 +110,7 @@ above, provided that you also meet all of these conditions:
     License.  (Exception: if the Program itself is interactive but
     does not normally print such an announcement, your work based on
     the Program is not required to print an announcement.)
-
+
 These requirements apply to the modified work as a whole.  If
 identifiable sections of that work are not derived from the Program,
 and can be reasonably considered independent and separate works in
@@ -169,7 +168,7 @@ access to copy from a designated place, then offering equivalent
 access to copy the source code from the same place counts as
 distribution of the source code, even though third parties are not
 compelled to copy the source along with the object code.
-
+
   4. You may not copy, modify, sublicense, or distribute the Program
 except as expressly provided under this License.  Any attempt
 otherwise to copy, modify, sublicense or distribute the Program is
@@ -226,7 +225,7 @@ impose that choice.
 
 This section is intended to make thoroughly clear what is believed to
 be a consequence of the rest of this License.
-
+
   8. If the distribution and/or use of the Program is restricted in
 certain countries either by patents or by copyrighted interfaces, the
 original copyright holder who places the Program under this License
@@ -256,7 +255,7 @@ make exceptions for this.  Our decision will be guided by the two goals
 of preserving the free status of all derivatives of our free software and
 of promoting the sharing and reuse of software generally.
 
-			    NO WARRANTY
+                            NO WARRANTY
 
   11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
 FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
@@ -278,9 +277,9 @@ YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
 PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.
 
-		     END OF TERMS AND CONDITIONS
-
-	    How to Apply These Terms to Your New Programs
+                     END OF TERMS AND CONDITIONS
+
+            How to Apply These Terms to Your New Programs
 
   If you develop a new program, and you want it to be of the greatest
 possible use to the public, the best way to achieve this is to make it
@@ -292,7 +291,7 @@ convey the exclusion of warranty; and each file should have at least
 the "copyright" line and a pointer to where the full notice is found.
 
     <one line to give the program's name and a brief idea of what it does.>
-    Copyright (C) 19yy  <name of author>
+    Copyright (C) <year>  <name of author>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -304,17 +303,16 @@ the "copyright" line and a pointer to where the full notice is found.
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-
+    You should have received a copy of the GNU General Public License along
+    with this program; if not, write to the Free Software Foundation, Inc.,
+    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 Also add information on how to contact you by electronic and paper mail.
 
 If the program is interactive, make it output a short notice like this
 when it starts in an interactive mode:
 
-    Gnomovision version 69, Copyright (C) 19yy name of author
+    Gnomovision version 69, Copyright (C) year name of author
     Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
     This is free software, and you are welcome to redistribute it
     under certain conditions; type `show c' for details.
@@ -337,5 +335,5 @@ necessary.  Here is a sample; alter the names:
 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
 consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Library General
+library.  If this is what you want to do, use the GNU Lesser General
 Public License instead of this License.
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
