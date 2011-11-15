Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQITu-0007JN-Cm
 for kexec@lists.infradead.org; Tue, 15 Nov 2011 12:51:18 +0000
Received: by ywp31 with SMTP id 31so6375687ywp.36
 for <kexec@lists.infradead.org>; Tue, 15 Nov 2011 04:51:16 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 15 Nov 2011 20:51:15 +0800
Message-ID: <CAM_iQpW8J7hybZVVLK9rtoMrWbU4AS82ob0iNdbAMCxv8hpC-A@mail.gmail.com>
Subject: kexec-tools git tree is tagged incorrectly?
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hello, Simon,

I am wondering why I get:

% git log --pretty=oneline -n 1
920f4ededd9627add3ca1cdea965d204f2ca43a7 kexec-tools: powerpc: Add
more 64bit relocations

% git describe
v1.101-618-g920f4ed

% git tag -l
v1.101
v2.0.0
v2.0.0-rc1
v2.0.1
v2.0.1-rc1
v2.0.2
v2.0.2-rc1
v2.0.2-rc2
v20061214
v20070319-rc
v20070330
v20071017-rc
v20071030
v20080219-rc
v20080221-rc
v20080226-rc
v20080227
v20080318-rc
v20080324

HEAD should be v2.0.2, isn't it?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
