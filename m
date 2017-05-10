Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d8JTV-0005sb-1e
 for kexec@lists.infradead.org; Wed, 10 May 2017 04:43:48 +0000
Received: by mail-pf0-f176.google.com with SMTP id e64so10027785pfd.1
 for <kexec@lists.infradead.org>; Tue, 09 May 2017 21:43:24 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH V2] elf_info: fix file_size if segment is
 excluded
References: <6edcc4dfcd9ed60265a5fde658ad2db4c4f28cad.1494337896.git.panand@redhat.com>
 <591288E6.7090401@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <3b66e9b1-0fcc-6618-83c1-a9bc73f128ad@redhat.com>
Date: Wed, 10 May 2017 10:13:19 +0530
MIME-Version: 1.0
In-Reply-To: <591288E6.7090401@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xlpang@redhat.com, ats-kumagai@wm.jp.nec.com
Cc: kexec@lists.infradead.org, dyoung@redhat.com, bhe@redhat.com



On Wednesday 10 May 2017 08:58 AM, Xunlei Pang wrote:
>> +				(*pt_loads)[i].file_size -= (temp_seg.file_size
>> +					+ end - start);
> Hi Pratyush,
>
> Don't we need to move the "(*pt_loads)[i].file_size" minus "(end - start)" down
> to the tail of "if (kvstart <  vend && kvend > vstart)" condition for all cases?

Yes..sent v3.

Thanks for review.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
