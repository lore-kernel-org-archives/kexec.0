Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1frm41-00086V-5i
 for kexec@lists.infradead.org; Mon, 20 Aug 2018 15:25:56 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH 1/2] arm64: Get 'info->page_offset' from PT_LOAD
 segments to support KASLR boot cases
Date: Mon, 20 Aug 2018 15:24:37 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355A60A@BPXM09GP.gisp.nec.co.jp>
References: <1531979021-31780-1-git-send-email-bhsharma@redhat.com>
 <1531979021-31780-2-git-send-email-bhsharma@redhat.com>
 <bf9dee4f-852d-fc6b-999a-02ea99dceb4d@redhat.com>
 <CACi5LpOKQ9TX9yWus6i9ZG_Ha8A+vPqs09o1Jh0B9O5vYED9BA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035590BC@BPXM09GP.gisp.nec.co.jp>
 <CACi5LpNdaKAa+YzS0zp2e16tewkcqkRay0QqbZcJGjDtK+5TTA@mail.gmail.com>
 <CACi5LpOh12o3T7FHFSV+4aYEtWS9ZLebyoW1yJ0EnegZJ6Nj2Q@mail.gmail.com>
In-Reply-To: <CACi5LpOh12o3T7FHFSV+4aYEtWS9ZLebyoW1yJ0EnegZJ6Nj2Q@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hello Bhupesh,

On 8/15/2018 3:55 PM, Bhupesh Sharma wrote:
> The kernel patch is now accepted in Linus's tree:
> commit e401b7c2c69008ad2fcdc154f7c5421281c90042
> Author: Bhupesh Sharma <bhsharma@redhat.com>
> Date:   Mon Jul 30 11:54:43 2018 +0530
> 
>     arm64, kaslr: export offset in VMCOREINFO ELF notes
> 
> Can you please pick this patchset and now apply it to makedumpfile source?

Thank you for informing me about it, and sorry for my delayed response.
I applied the patches to the devel branch.

commit 616c98d1abac6f348f13cfe55e2df5e1d5d26781
Author: Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu Jul 19 11:13:41 2018 +0530

    [PATCH] arm64: Add runtime kaslr offset if it exists

commit 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2
Author: Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu Jul 19 11:13:40 2018 +0530

    [PATCH] arm64: Get 'info->page_offset' from PT_LOAD segments to support KASLR boot cases

Thanks,
Kazu

> 
> Thanks,
> Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
