Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjJRE-0006Xc-RJ
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 00:47:41 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1385063bkc.36
 for <kexec@lists.infradead.org>; Thu, 13 Dec 2012 16:47:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50CA75A7.2060009@zytor.com>
References: <1355437112-9250-1-git-send-email-yinghai@kernel.org>
 <50CA75A7.2060009@zytor.com>
Date: Thu, 13 Dec 2012 16:47:38 -0800
Message-ID: <CAE9FiQVR=41H4-5y1CSyqjmaNYzO0b23rTCBvwmQVeFoYX6zkA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] kexec: put bzImage and ramdisk above 4G for x86
 64bit
From: Yinghai Lu <yinghai@kernel.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Dec 13, 2012 at 4:41 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Also, please do update the boot loader ID.

i squash that into  patch 4

[PATCH v6 4/6] kexec, x86: put ramdisk/cmd_line above 4G for 64bit bzImage

We could put ramdisk/cmdline above for bzImage on 64bit for protocol 2.12.

-v2: change ext_... handling to way that eric like.
-v3: set LOADER_TYPE_KEXEC

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
