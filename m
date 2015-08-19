Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZS3cG-0007qk-6t
 for kexec@lists.infradead.org; Wed, 19 Aug 2015 13:41:20 +0000
Received: by wijp15 with SMTP id p15so127240594wij.0
 for <kexec@lists.infradead.org>; Wed, 19 Aug 2015 06:40:58 -0700 (PDT)
Subject: Re: Dmesg not being dumped
References: <55D42056.5070709@kyup.com>
 <20150819131302.GA11631@dhcp-128-25.nay.redhat.com>
From: Nikolay Borisov <kernel@kyup.com>
Message-ID: <55D48768.4020207@kyup.com>
Date: Wed, 19 Aug 2015 16:40:56 +0300
MIME-Version: 1.0
In-Reply-To: <20150819131302.GA11631@dhcp-128-25.nay.redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: kexec@lists.infradead.org



On 08/19/2015 04:13 PM, Minfei Huang wrote:
> Hi. Nikolay.
Hi
> 
> Does kexec-tools work for original rhel kernel, like 3.10.0-xxx. Also do

Unfortunately I canno test with an official rhel kernel since we are not
using those. Also, the problem is not that kexec is not working at all,
but just that the dmesg log is not being saved in the vmcore-dmesg.txt
file. Here are the relevant portion of the my .config which deal with
debug info:

CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set

The failures is happening (according to my reading of the vmcore-dmesg.c
file) here:

+	if (!log_sz) {
+		fprintf(stderr, "Missing the struct log size export\n");
+		exit(64);
+	}

And log_size is being set here:

		str = "SIZE(printk_log)=";
		if (memcmp(str, pos, strlen(str)) == 0)
			log_sz = strtoull(pos + strlen(str), NULL, 10);

The pertinent question I guess is why this string cannot be found in the
resulting vmcore image. I just tried with kexec 2.0.10 and the result is
the same.

> you specify the config to build the kernel? It is appropriate if you can
> paste the config related to the kexec.
> 
> Thanks
> Minfei
> 
> On 08/19/15 at 09:21am, Nikolay Borisov wrote:
>> Hello,
>>
>> I've recently noticed that when creating crashdumps the dmesg is not
>> being saved. The error reported is this: "Missing the struct log size
>> export". I've tested with both kernel 4.1.1 and 3.12.28. My version of
>> kexec tools is : kexec-tools 2.0.9 released 04 June 2015. The kernel has
>> been compiled with debugging info so the respective symbol should be
>> exported but apparently it is not. Any ideas how to debug that?
>>
>> [Please CC me as I'm not subscribed to the mailing list.]
>>
>> Regards,
>> Nikolay
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
