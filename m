Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fDehn-0006LX-S6
 for kexec@lists.infradead.org; Tue, 01 May 2018 23:29:09 +0000
Received: by mail-pg0-x22f.google.com with SMTP id j11-v6so9250197pgf.2
 for <kexec@lists.infradead.org>; Tue, 01 May 2018 16:28:54 -0700 (PDT)
Date: Tue, 1 May 2018 16:28:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v7 1/3] vmcore: add API to collect hardware
 dump in second kernel
Message-ID: <20180501162851.0fceb210@xeon-e3>
In-Reply-To: <b6065b53c5446d98ee55e09119f6821f979418d4.1525197408.git.rahul.lakkireddy@chelsio.com>
References: <cover.1525197407.git.rahul.lakkireddy@chelsio.com>
 <b6065b53c5446d98ee55e09119f6821f979418d4.1525197408.git.rahul.lakkireddy@chelsio.com>
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
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ganeshgr@chelsio.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, ebiederm@xmission.com

On Tue,  1 May 2018 23:57:45 +0530
Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> wrote:

> +
> +int vmcore_add_device_dump(struct vmcoredd_data *data)
> +{
> +	return __vmcore_add_device_dump(data);
> +}
> +EXPORT_SYMBOL(vmcore_add_device_dump);
> +#endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP

Why the stub wrapper function? 
it does nothing.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
