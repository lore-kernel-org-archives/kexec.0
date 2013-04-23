Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wg0-x229.google.com ([2a00:1450:400c:c00::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUYKR-000268-7t
 for kexec@lists.infradead.org; Tue, 23 Apr 2013 08:11:55 +0000
Received: by mail-wg0-f41.google.com with SMTP id e11so1410708wgh.4
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 01:11:50 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 23 Apr 2013 16:11:50 +0800
Message-ID: <CAFNq8R57pLzwGZCca41BoioyLqDPQp=_-6eqB4+j7Mint1mHYQ@mail.gmail.com>
Subject: Why kdump just support ELF64CLASS?
From: Li Haifeng <omycle@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org

Hi, eric.

I used kdump tool to dump vmcore info instead of "/proc/vmcore" on
ARM-32 soc. But the kdump just support ELF64CLASS.

Then I doubt why kdump just support ELF64CLASS. Is there a story? :-)

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
