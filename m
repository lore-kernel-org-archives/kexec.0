Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hpZUf-00058p-4M
 for kexec@lists.infradead.org; Mon, 22 Jul 2019 14:40:51 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [RFC] makedumpfile: exclude ZFS file cache pages
Date: Mon, 22 Jul 2019 14:35:53 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03581F01@BPXM09GP.gisp.nec.co.jp>
References: <CAPEr6wVVboDUxUrGE77NtS2WWrhR8vV0EEGPvPMJ+hfzkAb26g@mail.gmail.com>
In-Reply-To: <CAPEr6wVVboDUxUrGE77NtS2WWrhR8vV0EEGPvPMJ+hfzkAb26g@mail.gmail.com>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Donald Brady <don.brady@delphix.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> From: kexec <kexec-bounces@lists.infradead.org> On Behalf Of Donald Brady
> Sent: Friday, July 19, 2019 3:44 PM
> To: kexec@lists.infradead.org
> Subject: [RFC] makedumpfile: exclude ZFS file cache pages
> 
> Hello,
> 
> I have for consideration a makedumpfile patch that can exclude the ZFS
> file data cache pages. This is similar in capability as the exclusion
> of the VFS page cache pages.
> 
> My question to this list is how to proceed?  Should I post a patch or
> should I first explain how the ZFS pages are being marked and see if
> others here can recommend a better approach?

Hi Don,

Either is OK, but I don't have any knowledge about ZFS implementation
so the explanation of that and what your patch is going to do will be
helpful at least for me to review/discuss it. And as you say, someone
here may be able to help.

Thanks,
Kazu

> 
> Long term, ZFS should participate in the VFS page cache. However, that
> is a significant change and won't be available in the foreseeable
> future. There is an immediate benefit from excluding ZFS file cache
> pages that will benefit crash dump users that use ZFS.
> 
> Thanks in advance for your help!
> -Don
> 
> --
> DON BRADY
> Staff Engineer
> Delphix.com
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
