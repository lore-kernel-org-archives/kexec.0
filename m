Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOv83-00GJOq-7M
 for kexec@lists.infradead.org; Wed, 24 Mar 2021 04:28:25 +0000
Received: by mail-pf1-x435.google.com with SMTP id 11so16433457pfn.9
 for <kexec@lists.infradead.org>; Tue, 23 Mar 2021 21:28:22 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Sung <patricksung@gmail.com>
Date: Wed, 24 Mar 2021 12:28:08 +0800
Message-ID: <CAK5_k=Lao5dYtAWrBMXViM0iEdT0QOj-fPiEsuvkfTogfF=6dA@mail.gmail.com>
Subject: kexec does not work for kernel version with patch level >= 256
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

Hello all,

I am using the 4.9 long term kernel which is currently at 4.9.262.
When using this kernel with kexec-tools it prints out this error

  Unsupported utsname.release: 4.9.262
  Cannot load <kdump images path>

A quick search in the code shows that kexec/kernel_version.c doing this check:

  if (major >= 256 || minor >= 256 || patch >= 256) {

and also in kexec/kexec.h
  #define KERNEL_VERSION(major, minor, patch) \
    (((major) << 16) | ((minor) << 8) | patch)

which explains the reason for the range check in kernel_version.c

Increasing the number of bits allowed in "patch" seems to fix the issue.

Thanks,
Patrick

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
