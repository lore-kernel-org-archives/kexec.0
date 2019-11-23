Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYWQ5-0005t1-JG
 for kexec@lists.infradead.org; Sat, 23 Nov 2019 14:29:55 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xANEOPeb093578
 for <kexec@lists.infradead.org>; Sat, 23 Nov 2019 14:29:44 GMT
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2wewdqs2j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Sat, 23 Nov 2019 14:29:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xANETJYn021581
 for <kexec@lists.infradead.org>; Sat, 23 Nov 2019 14:29:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2wesvyfj7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Sat, 23 Nov 2019 14:29:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xANETdXQ024676
 for <kexec@lists.infradead.org>; Sat, 23 Nov 2019 14:29:42 GMT
Subject: Re: [PATCH v4 0/4] makedumpfile/arm64: Add support for ARMv8.2
 extensions
References: <mailman.13491.1574446920.2486.kexec@lists.infradead.org>
 <483111234.14383042.1574448460262.JavaMail.zimbra@redhat.com>
From: John Donnelly <John.P.Donnelly@Oracle.com>
Message-ID: <afbba516-250b-3325-d453-0c37bc63d1b6@Oracle.com>
Date: Sat, 23 Nov 2019 08:29:38 -0600
MIME-Version: 1.0
In-Reply-To: <483111234.14383042.1574448460262.JavaMail.zimbra@redhat.com>
Content-Language: en-US
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
To: kexec@lists.infradead.org

On 11/22/19 12:47 PM, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
>>
>> Hi Bhupesh,
>>
>> I recall seeing a reference to modification are needed for the crash CLI also
>> to support 5.4.0-rc with your kernel patches cited here.
>>   
>> Where would I find that at ?  I don?t see crash on Giblab.
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_crash-2Dutility_crash&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=Idg6a1AITiQdn_Ne3jgviBQAPUgdP7PzV00Z47gRHe8&s=g2_ZOSi3nOdUQgU-MvV3nUWcDbnnanKhzPGPUKnFm-A&e=
> 
>>


Hi David ,

Thank you. I verified that works with Bhupesh's makedumpfile and 5.4.0 
kernel patches.



-- 
Thank You,
John

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
