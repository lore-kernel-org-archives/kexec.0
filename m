Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRQtj-005KrI-UK
 for kexec@lists.infradead.org; Wed, 31 Mar 2021 02:48:02 +0000
Date: Wed, 31 Mar 2021 10:47:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec does not work for kernel version with patch level >= 256
Message-ID: <20210331024745.GB29970@MiWiFi-R3L-srv>
References: <CAK5_k=Lao5dYtAWrBMXViM0iEdT0QOj-fPiEsuvkfTogfF=6dA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK5_k=Lao5dYtAWrBMXViM0iEdT0QOj-fPiEsuvkfTogfF=6dA@mail.gmail.com>
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
To: Patrick Sung <patricksung@gmail.com>
Cc: kexec@lists.infradead.org, dyoung@redhat.com, ebiederm@xmission.com, horms@verge.net.au

On 03/24/21 at 12:28pm, Patrick Sung wrote:
> Hello all,
> 
> I am using the 4.9 long term kernel which is currently at 4.9.262.
> When using this kernel with kexec-tools it prints out this error
> 
>   Unsupported utsname.release: 4.9.262
>   Cannot load <kdump images path>
> 
> A quick search in the code shows that kexec/kernel_version.c doing this check:
> 
>   if (major >= 256 || minor >= 256 || patch >= 256) {
> 
> and also in kexec/kexec.h
>   #define KERNEL_VERSION(major, minor, patch) \
>     (((major) << 16) | ((minor) << 8) | patch)

Yeah, this seems to be a good catch. The existing longterm kenrel 4.9.262
does cause the problem. I am not very sure about the longterm kernel
version numbering, maybe we can leave 16 bits for for patch number to
avoid the longterm kernel issue?

Is there document telling the longterm kernel version numbering, or any
pointer?

Thanks
Baoquan

> 
> which explains the reason for the range check in kernel_version.c
> 
> Increasing the number of bits allowed in "patch" seems to fix the issue.
> 
> Thanks,
> Patrick
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
