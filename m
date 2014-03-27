Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Thu, 27 Mar 2014 10:04:19 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <420609342.5318732.1395929059090.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.28599.1395907790.1059.kexec@lists.infradead.org>
References: <mailman.28599.1395907790.1059.kexec@lists.infradead.org>
Subject: Re: [PATCH 0/3] add LPAE support for kexec and kernel (Liu Hua)
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, linux-arm-kernel@lists.infradead.org, sdu liu <sdu.liu@huawei.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>



----- Original Message -----

> The patch series introduce LPAE support for user space
> utility kexec(the last) and ARM linux kernel(the others).
> 
> I have tested the patch series in armA15 platform which have
> more than 4G memory.

Hello Liu,

I'm curious how you tested this?  The crash utility does not have
any specific support for LPAE on ARM, and a couple years ago I 
asked on the crash-utility mailing list whether any of the ARM
developers were working on it.  But at that time none of them were
working with LPAE.  I see that you are on the crash-utility mailing
list -- are you planning to post follow-up patches to the crash-utility?

Thanks,
  Dave

 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
