Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bdCGn-00055Q-QY
 for kexec@lists.infradead.org; Fri, 26 Aug 2016 08:13:47 +0000
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0OCI008ORC67E490@mailout3.w1.samsung.com> for
 kexec@lists.infradead.org; Fri, 26 Aug 2016 09:13:19 +0100 (BST)
From: YoungHyun Yoo <yooyoo.yoo@samsung.com>
Subject: Re: Re: [PATCH] kexec: socket not released when error situation occur.
Date: Fri, 26 Aug 2016 17:13:03 +0900
Message-id: <20160826081303.28340-1-yooyoo.yoo@samsung.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: bhe@redhat.com
Cc: YoungHyun Yoo <yooyoo.yoo@samsung.com>, horms@verge.net.au, kexec@lists.infradead.org

On 08/26/16 at 11:19 am, Baoquan He wrote:
>On 08/25/16 at 11:15am, YoungHyun Yoo wrote:
>> Fix resourceleek in ifdown function when error occur.
>
>resource leak?

Yes resource leak. Sorry for the typo.

>
>> 
>> Signed-off-by: YoungHyun Yoo <yooyoo.yoo@samsung.com>
>> ---
>>  kexec/ifdown.c | 26 +++++++++++++++-----------
>>  1 file changed, 15 insertions(+), 11 deletions(-)
>> 
>> diff --git a/kexec/ifdown.c b/kexec/ifdown.c
>> index 46b7bef..9679ad7 100644
>> --- a/kexec/ifdown.c
>> +++ b/kexec/ifdown.c
>> @@ -1,6 +1,6 @@
>>  /*
>> - * ifdown.c	Find all network interfaces on the system and
>> - *		shut them down.
>> + * ifdown.c Find all network interfaces on the system and
>> + *      shut them down.
>>   *
>>   */
>>  char *v_ifdown = "@(#)ifdown.c  1.11  02-Jun-1998  miquels@cistron.nl";
>> @@ -20,10 +20,10 @@ char *v_ifdown = "@(#)ifdown.c  1.11  02-Jun-1998  miquels@cistron.nl";
>>  #include <netinet/in.h>
>>  
>>  /*
>> - *	First, we find all shaper devices and down them. Then we
>> - *	down all real interfaces. This is because the comment in the
>> - *	shaper driver says "if you down the shaper device before the
>> - *	attached inerface your computer will follow".
>> + *  First, we find all shaper devices and down them. Then we
>> + *  down all real interfaces. This is because the comment in the
>> + *  shaper driver says "if you down the shaper device before the
>> + *  attached inerface your computer will follow".
>>   */
>>  int ifdown(void)
>>  {
>> @@ -34,13 +34,13 @@ int ifdown(void)
>>  	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
>>  		fprintf(stderr, "ifdown: ");
>>  		perror("socket");
>> -		return -1;
>> +		goto error;
>>  	}
>>  
>>  	if ((ifa = if_nameindex()) == NULL) {
>>  		fprintf(stderr, "ifdown: ");
>>  		perror("if_nameindex");
>> -		return -1;
>> +		goto error;
>>  	}
>>  
>>  	for (shaper = 1; shaper >= 0; shaper--) {
>> @@ -57,18 +57,22 @@ int ifdown(void)
>>  			if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) {
>>  				fprintf(stderr, "ifdown: shutdown ");
>>  				perror(ifp->if_name);
>> -				return -1;
>> +				goto error;
>>  			}
>>  			ifr.ifr_flags &= ~(IFF_UP);
>>  			if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) {
>>  				fprintf(stderr, "ifdown: shutdown ");
>>  				perror(ifp->if_name);
>> -				return -1;
>> +				goto error;
>>  			}
>>  
>>  		}
>>  	}
>> -	close(fd);
>>  
>> +	close(fd);
>>  	return 0;
>> +
>> +error:
>> +	close(fd);
>> +	return -1;
>>  }
>> -- 
>> 2.9.0.GIT
>> 
>> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
