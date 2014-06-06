Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wt1Hz-0007Zc-V3
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 21:03:04 +0000
Received: by mail-qa0-f49.google.com with SMTP id cm18so4706653qab.8
 for <kexec@lists.infradead.org>; Fri, 06 Jun 2014 14:02:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53922C01.4040800@zytor.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140603131203.GA23395@redhat.com>
 <20140605083134.GE3506@darkstar.nay.redhat.com>
 <20140605150159.GA14083@redhat.com>
 <20140606073748.GC3343@darkstar.nay.redhat.com>
 <53922686.6010301@zytor.com>
 <CAL01qpsf_-Ae_P-mfmqfu6DYavcb866YUnE4XM_7vdhfcAvMGg@mail.gmail.com>
 <53922C01.4040800@zytor.com>
Date: Fri, 6 Jun 2014 22:02:40 +0100
Message-ID: <CAL01qpu4P0+_yNoBekcpohuSv+n=u=a8sEnBMhfi7DzDRiiEfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in kernel
 loading
From: Matt Fleming <matt.fleming@intel.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, ebiederm@xmission.com, "jkosina@suse.cz" <jkosina@suse.cz>, chaowang@redhat.com, Dave Young <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On 6 June 2014 22:00, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Yes, presumably (as a separate patch since the actual commit is quite
> large.)  The patch needs to have a good description why the original
> patch was wrong.

Right. I'll take a look at this in the morning.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
