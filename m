Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x236.google.com ([2607:f8b0:400e:c03::236])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bIqeh-0002NH-JH
 for kexec@lists.infradead.org; Fri, 01 Jul 2016 05:06:20 +0000
Received: by mail-pa0-x236.google.com with SMTP id bz2so35109478pad.1
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 22:05:58 -0700 (PDT)
Date: Fri, 1 Jul 2016 14:11:12 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC] arm64: kexec_file_load support
Message-ID: <20160701051111.GL20774@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
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
To: ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: will.deacon@arm.com, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

I'm not sure whether there is any demand for kexec_file_load
support on arm64, but anyhow I'm working on this and now
my early prototype code does work fine.

There is, however, one essential issue:
While arm64 kernel requires a device tree blob to be set up
correctly at boot time, the current system call API doesn't
have this parameter.
    int kexec_file_load(int kernel_fd, int initrd_fd,
                        unsigned long cmdline_len, const char *cmdline_ptr,
                        unsigned long flags);

Should we invent a new system call, like kexec_file_load2,
and, if so, what kind of interface would be desired?

Thanks,
-Takahiro AKASHI

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
