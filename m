Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hoYnT-0007AH-17
 for kexec@lists.infradead.org; Fri, 19 Jul 2019 19:44:04 +0000
Received: by mail-ed1-x52f.google.com with SMTP id s49so600827edb.1
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2019 12:44:02 -0700 (PDT)
MIME-Version: 1.0
From: Donald Brady <don.brady@delphix.com>
Date: Fri, 19 Jul 2019 13:43:49 -0600
Message-ID: <CAPEr6wVVboDUxUrGE77NtS2WWrhR8vV0EEGPvPMJ+hfzkAb26g@mail.gmail.com>
Subject: [RFC] makedumpfile: exclude ZFS file cache pages
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

Hello,

I have for consideration a makedumpfile patch that can exclude the ZFS
file data cache pages. This is similar in capability as the exclusion
of the VFS page cache pages.

My question to this list is how to proceed?  Should I post a patch or
should I first explain how the ZFS pages are being marked and see if
others here can recommend a better approach?

Long term, ZFS should participate in the VFS page cache. However, that
is a significant change and won't be available in the foreseeable
future. There is an immediate benefit from excluding ZFS file cache
pages that will benefit crash dump users that use ZFS.

Thanks in advance for your help!
-Don

-- 
DON BRADY
Staff Engineer
Delphix.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
