Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x234.google.com ([2607:f8b0:4001:c02::234])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDiVu-0005jO-8v
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 21:38:13 +0000
Received: by mail-ia0-f180.google.com with SMTP id f27so863158iae.25
 for <kexec@lists.infradead.org>; Thu, 07 Mar 2013 13:38:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130307152108.GC2790@redhat.com>
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com>
Date: Thu, 7 Mar 2013 13:38:05 -0800
Message-ID: <CAE9FiQW8nVcNoffm82Wz4B9k1wPWgJuDo3K+a9t10iTFgYhp0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to
 speedup kernel dump process
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, hpa@zytor.com, Jingbai Ma <jingbai.ma@hp.com>

On Thu, Mar 7, 2013 at 7:21 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> Looks like now hpa and yinghai have done the work to be able to load
> kdump kernel above 4GB. I am assuming this also removes the restriction
> that we can only reserve 512MB or 896MB in second kernel.

Yes, From v3.9 and kexec-tools 2.0.4 on x86 64bit.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
