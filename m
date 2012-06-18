Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SgWLW-0002ne-Gl
 for kexec@lists.infradead.org; Mon, 18 Jun 2012 07:26:00 +0000
Message-ID: <4FDED7D8.7070106@hitachi.com>
Date: Mon, 18 Jun 2012 16:25:12 +0900
From: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] Export offsets of VMCS fields as note information
 for kdump
References: <4FB35C48.30708@cn.fujitsu.com> <4FB92D5A.3060507@redhat.com>
 <4FB9A92D.7050108@cn.fujitsu.com> <4FB9FE08.4050905@redhat.com>
 <4FBA05F6.8070804@cn.fujitsu.com> <4FBA0C8A.2050003@redhat.com>
 <4FBB0ACA.2040907@cn.fujitsu.com> <4FC30C40.80500@cn.fujitsu.com>
 <4FC37D94.3080404@redhat.com> <4FC47579.2040504@cn.fujitsu.com>
 <4FD58399.4050700@cn.fujitsu.com> <4FD9E3FF.4050906@redhat.com>
In-Reply-To: <4FD9E3FF.4050906@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>, Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>, yrl.pp-manager.tt@hitachi.com, vgoyal@redhat.com

Hi, Avi, Yanfei

I'm YOSHIDA Masanori from Hitachi, a developer of livedump.

 >> And here is a new case from the LinuxCon Japan:
 >>
 >> Developers from Hitach are now developing a new livedump mechanism for the
 >> same reason as ours. They have come to the situation *many times* that guest
 >> machines crashed due to host's failures, in particular, under development.
 >
 > This has happened to me as well, possible even more times .  I don't
 > use crash dumps for debugging but different people may use different
 > techniques.

As Yanfei's introduction, I'm developing livedump for cases where
guests crash due to host's failures.

Especially in very important systems, it is strongly requested to
identify the root cause of any failure even if it is very rare.
For this purpose, crash dumps must be obtained.
Therefore, we think livedump technique must be applied to the
virtualization system on that kind of area.

 >>> After the buggy situation is reproduced, we panic the host *manually*.
 >>> Then we could use userland tools to get guest machine's crash dump from 
host machine's
 >>> with the feature provided by this patch set. Finally we could analyse them 
separately
 >>> to find which side causes the problem.
 >>>
 >>
 >> Could you please tell me your attitude towards this patch?
 >
 > I still dislike it conceptually.  But let me do a technical review of
 > the latest version.

Actually, current implementation of livedump is just a core part,
which dumps only the image of kernel space. And I'd like to expand
it to obtain guest image at the same time too.
Also for this situation, VMCSINFO seems necessary to be exported.

Thanks,
YOSHIDA Masanori

Yokohama Research Laboratory,
Hitachi, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
